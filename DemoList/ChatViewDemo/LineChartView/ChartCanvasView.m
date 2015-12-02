//
//  ChartCanvasView.m
//  myDemoPro
//
//  Created by luoyan on 14/12/17.
//  Copyright (c) 2014年 mysoft. All rights reserved.
//

#import "ChartCanvasView.h"
#import <CoreText/CoreText.h>

typedef enum {
    caculateAllPositiveNumberType = 1,  //全是正数的情况。
    caculateAllNegativeType,            //全是负数的情况。
    caculateMixtureType,                //有正有负的情况。
}CaculateType;


@interface ChartCanvasView()
{
    float zeroHeight;
    float xAxisHeight;
    BOOL isNeedOrder;
    float totalValue;
    float contentMarginWidth;
    CaculateType caculateType;
    
}

@property (nonatomic,strong) NSMutableArray *xAxisPoints;
@property (nonatomic,strong) NSMutableArray *pointKeys;
@property (nonatomic,strong) NSMutableArray *stepValues;

@property (nonatomic,strong) UIView         *dragPointView;

@property (nonatomic,assign) float maxValue;
@property (nonatomic,assign) float minValue;
@property (nonatomic,assign) float stepValue;
@property (nonatomic,assign) float xAxisRangWidth;
@property (nonatomic,assign) float stepHeight;
@property (nonatomic,strong) UIScrollView *contentShowView;
@end

@implementation ChartCanvasView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.objectArray = [[NSMutableArray alloc] init];
        [self.objectArray removeAllObjects];
        self.stepValues = [[NSMutableArray alloc] init];
        self.xAxisPoints = [[NSMutableArray alloc] init];
        isNeedOrder = NO;
    }
    return self;
}

- (void)reloadData
{
    [self.contentShowView.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self prepareInitData];
    
    [self drawXAxisLayer:self.pointKeys];
    [self drawYAxisLayer];
    [self drawVerticalLine];
    
    //绘制折线和圆点
    for (int i = 0; i<self.objectArray.count; i++) {
        NSArray *dataArray = [self.objectArray objectAtIndex:i];
        NSMutableArray *points = [[NSMutableArray alloc] init];
        [dataArray enumerateObjectsUsingBlock:^(NSDictionary *objDic, NSUInteger idx, BOOL *stop) {
            [points addObject:[objDic objectForKey:@"yValue"]];
        }];
        
        [self drawBrokenLineShapeLayer:points];
        [self addPointsLayerToView:points];
    }
    if (self.isShowDragPointView) {
        [self drawDragPointView];
        [self dragPointViewMoveToLastData];
    }
}

#pragma mark 绘制图形前，数据准备
- (void)prepareInitData
{
    if (!self.yUnit) {
        self.yUnit = @"";
    }
    if (!self.pointKeys) {
        self.pointKeys = [[NSMutableArray alloc] init];
    } else {
        [self.pointKeys removeAllObjects];
    }
    
    if (!self.contentShowView) {
        self.contentShowView = [[UIScrollView alloc] initWithFrame:CGRectMake(kMarginLeftWidth, kMarginTopHeight, self.frame.size.width - kMarginLeftWidth - kMarginRightWidth, self.frame.size.height-kMarginTopHeight)];

        self.contentShowView.showsHorizontalScrollIndicator = NO;
        self.contentShowView.bounces = NO;
        self.contentShowView.userInteractionEnabled = NO;
        
        [self addSubview:self.contentShowView];
    }
    if (self.isNeedContentMarginWidth) {
        contentMarginWidth = 5;
    } else {
        contentMarginWidth = 0;
    }
    
    [self fecthMaxAndMinYaxisValue];
    [self caculateXAxisRangWidth];
    
}

#pragma mark 计算X轴上刻度间距
- (void)caculateXAxisRangWidth
{
    if (self.pointKeys.count>1) {
        self.xAxisRangWidth = (self.contentShowView.frame.size.width - contentMarginWidth*2)/(self.pointKeys.count-1);
    } else {
        self.xAxisRangWidth = self.contentShowView.frame.size.width/2;
    }
}

#pragma mark 获取最大值和最小值
- (void)sortValues:(NSArray*)values
{
    [values enumerateObjectsUsingBlock:^(NSString *numberString, NSUInteger idx, BOOL *stop) {
        float number = [numberString floatValue];
        if (number > self.maxValue) {
            self.maxValue = number;
        }
    }];
}

- (void)fecthMaxAndMinYaxisValue
{
    self.maxValue = self.minValue = 0;
    for (int i = 0; i<self.objectArray.count; i++) {
        NSArray *dataArray = [self.objectArray objectAtIndex:i];
        NSMutableArray *points = [[NSMutableArray alloc] init];
        [dataArray enumerateObjectsUsingBlock:^(NSDictionary *objDic, NSUInteger idx, BOOL *stop) {
            [points addObject:[objDic objectForKey:@"yValue"]];
            if (i==0) {
                [self.pointKeys addObject:[objDic objectForKey:@"xValue"]];
            }
        }];
        [self sortValues:points];
    }
    
    if (_maxValue <= 10)
        _maxValue = 10;
    else if (_maxValue <= 20)
        _maxValue = 20;
    else if (_maxValue <= 50)
        _maxValue = 50;
    else if (_maxValue <= 100)
        _maxValue = 100;
    else if (_maxValue <= 1000)
    {
        int m = _maxValue/250;
        int n = (int)_maxValue%250;
        
        m += n > 0 ? 1 : 0;
        _maxValue = m * 250;
    }
    else if (_maxValue <= 10000)
    {
        int m = _maxValue/500;
        int n = (int)_maxValue%500;
        
        m += n > 0 ? 1 : 0;
        _maxValue = m * 500;
    }
    else
    {
        int m = _maxValue/1000;
        int n = (int)_maxValue%1000;
        
        m += n > 0 ? 1 : 0;
        _maxValue = m * 1000;
    }
    
    xAxisHeight = self.contentShowView.frame.size.height-kMarginBottomHeight;
    self.stepHeight = xAxisHeight/self.stepCount;
    
    caculateType = caculateAllPositiveNumberType;
    totalValue = self.maxValue;
    float stepValue = self.maxValue/self.stepCount;
    
    for (int i = 0; i<=self.stepCount; i++)
    {
        float yAxisValue = i*stepValue;
        NSString *yValueString;
        
        int m = yAxisValue/1000;
        int n = (int)yAxisValue%1000;
        
        if (n == 0 && yAxisValue > 0)
            yValueString = [NSString stringWithFormat:@"%zdK", m];
        else
            yValueString= [NSString stringWithFormat:@"%0.0f",yAxisValue];
        
        [self.stepValues addObject:yValueString];
    }
    zeroHeight = xAxisHeight;
    
    
    NSLog(@"minValue = [%f],maxValue = [%f],zeroHeight = [%f],xAxisHeight = [%f]",self.minValue,self.maxValue,zeroHeight,xAxisHeight);
}

- (void)drawVerticalLine
{
    for (int i = 0; i<self.verticalLineCount; i++) {
        float marginWidth = self.contentShowView.frame.size.width/self.verticalLineCount;
        float orginx = (i+1)*marginWidth;
        CGRect rect = CGRectMake(orginx, 0, 1, xAxisHeight);
        NSLog(@"rect = %@",NSStringFromCGRect(rect));
        CALayer *verticalLineLayer = [self drawStepLineLayer:rect];
        [self.contentShowView.layer addSublayer:verticalLineLayer];
    }
}

#pragma mark 绘制网格线
- (CALayer*)drawStepLineLayer:(CGRect)rect
{
    CALayer *lineLayer = [CALayer layer];
    lineLayer.contentsScale = [UIScreen mainScreen].scale;
    lineLayer.frame = rect;
    lineLayer.backgroundColor = kChartViewLineColor.CGColor;
    return lineLayer;
}

- (CALayer*)drawDashedLineLayer:(CGRect)rect
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    // 设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:kChartViewLineColor.CGColor];
    
    // 线的宽度 每条线的间距
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:6],
      [NSNumber numberWithInt:2],nil]];
    
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, rect.origin.x, rect.origin.y);
    CGPathAddLineToPoint(path, NULL, rect.origin.x+rect.size.width,rect.origin.y);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    return shapeLayer;
}

#pragma mark 画x轴
- (CALayer*)drawXLineLayer:(CGRect)rect
{
    CALayer *lineLayer = [CALayer layer];
    lineLayer.contentsScale = [UIScreen mainScreen].scale;
    lineLayer.frame = rect;
    lineLayer.backgroundColor = kChartViewLineColor.CGColor;
    return lineLayer;
}

#pragma mark 绘制X轴上的刻度
- (CALayer*)drawStepXMarkLayer:(CGRect)rect
{
    CALayer *lineLayer = [CALayer layer];
    lineLayer.contentsScale = [UIScreen mainScreen].scale;
    lineLayer.frame = rect;
    lineLayer.backgroundColor = kChartViewLineColor.CGColor;
    return lineLayer;
}

#pragma mark 绘制Y轴上的信息
- (void)drawYAxisLayer
{
    //绘制左边Y轴
    CALayer *yLeftAxisLayer = [CALayer layer];
    yLeftAxisLayer.frame = CGRectMake(kMarginLeftWidth-1, kMarginTopHeight, 1, xAxisHeight);
    yLeftAxisLayer.contentsScale = [UIScreen mainScreen].scale;
    yLeftAxisLayer.backgroundColor = kChartViewLineColor.CGColor;
    [self.layer addSublayer:yLeftAxisLayer];
    
    //绘制右边边Y轴
    CALayer *yRightAxisLayer = [CALayer layer];
    yRightAxisLayer.frame = CGRectMake(self.contentShowView.frame.origin.x+self.contentShowView.frame.size.width, kMarginTopHeight, 1, xAxisHeight);
    yRightAxisLayer.contentsScale = [UIScreen mainScreen].scale;
    yRightAxisLayer.backgroundColor = kChartViewLineColor.CGColor;
    [self.layer addSublayer:yRightAxisLayer];
    
    //绘制右边Y轴上的单位
    CGRect yUnitTextRect = CGRectMake(yRightAxisLayer.frame.origin.x+2, -2+kMarginTopHeight, kMarginRightWidth-2, 200);
    CATextLayer *yUnitLayer = [self drawTextLayerWithRect:yUnitTextRect andText:self.yUnit andTextAlign:kCAAlignmentLeft color:kChartViewTextColor];
    [self.layer addSublayer:yUnitLayer];
    
    NSInteger count = caculateType == caculateMixtureType ? self.stepCount + 1 : self.stepCount;
    
    for (int i = 0; i<= count; i++)
    {
        if (i%2==0) {
            NSString *yValueString = isNeedOrder?[self.stepValues objectAtIndex:count-i]:[self.stepValues objectAtIndex:i];
            CGSize fontSize = [yValueString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kXAxisFontSize]}];
            CGFloat orginX = (kMarginLeftWidth-fontSize.width - 5)>0?(kMarginLeftWidth-fontSize.width - 5):0;
            CGRect textRect = CGRectMake(orginX,xAxisHeight - self.stepHeight*i - fontSize.height/2 + kMarginTopHeight, fontSize.width>kMarginLeftWidth?kMarginLeftWidth:fontSize.width, fontSize.height);
            CATextLayer *textLayer = [self drawTextLayerWithRect:textRect andText:yValueString andTextAlign:kCAAlignmentRight color:kChartViewTextColor];
            //加左边Y轴刻度文字
            [self.layer addSublayer:textLayer];
        }
        
        float orginY = xAxisHeight - self.stepHeight*i;
        CGRect lineRect = CGRectMake(0, orginY,self.contentShowView.frame.size.width, 1);
        CALayer *lineLayer;
        if (i==0 || i==count) {
            NSLog(@"lineRect = %@",NSStringFromCGRect(lineRect));
            lineLayer = [self drawStepLineLayer:lineRect];
        } else {
            NSLog(@"DashedLineRect = %@",NSStringFromCGRect(lineRect));
            lineLayer = [self drawDashedLineLayer:lineRect];
        }
        [self.contentShowView.layer addSublayer:lineLayer];
    }
}

#pragma mark 绘制X轴上的信息
- (void)drawXAxisLayer:(NSArray*)xValues
{
    NSUInteger index = xValues.count/2;
    for (NSUInteger idx = 0; idx<xValues.count; idx++) {
        NSUInteger showIndex = idx;
        
        //计算X轴上的刻度X值
        CGFloat xContentWidth = (self.contentShowView.frame.size.width-contentMarginWidth*2)/(xValues.count-1);
        CGFloat orginCenterX = contentMarginWidth+xContentWidth*idx;
        [self.xAxisPoints addObject:@(orginCenterX)];
        
        if (xValues.count > 4)
        {
            if (idx != 0 && idx!=xValues.count-1)
            {
                if (idx != index) {
                    continue;
                }
            }
        }
        NSString *xValue = [xValues objectAtIndex:idx];
        CGSize fontSize = [xValue sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kXAxisFontSize]}];
        CGRect rect = CGRectMake(kMarginLeftWidth+showIndex*self.xAxisRangWidth - fontSize.width/2 + contentMarginWidth,xAxisHeight + 2 + kMarginTopHeight, fontSize.width, fontSize.height);
        CATextLayer *textLayer = [self drawTextLayerWithRect:rect andText:xValue andTextAlign:kCAAlignmentLeft color:kChartViewTextColor];
        [self.layer addSublayer:textLayer];
        
    }
}

#pragma mark 绘制XY轴上的文字信息
- (CATextLayer*)drawTextLayerWithRect:(CGRect)rect andText:(NSString*)string andTextAlign:(NSString*)alignmentMode color:(UIColor*)color
{
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = rect;
    textLayer.string = string;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    textLayer.alignmentMode = alignmentMode;//kCAAlignmentCenter;
    textLayer.foregroundColor = color.CGColor;
    textLayer.font = (__bridge CFTypeRef)(@"Helvetica");
    textLayer.fontSize = kXAxisFontSize;
    textLayer.wrapped = YES;
    return textLayer;
}

#pragma mark 绘制折线部分
- (void)drawBrokenLineShapeLayer:(NSArray*)dataArray
{
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.contentsScale = [UIScreen mainScreen].scale;
    lineLayer.lineWidth = 1.5;
    UIBezierPath *shapePath = [UIBezierPath bezierPath];
    [dataArray enumerateObjectsUsingBlock:^(NSString *pointValue, NSUInteger idx, BOOL *stop) {
        float point = [pointValue floatValue];
        if (idx == 0) {
            [shapePath moveToPoint:CGPointMake(idx*self.xAxisRangWidth + contentMarginWidth, [self getOrginY:point])];
        } else {
            [shapePath addLineToPoint:CGPointMake(idx*self.xAxisRangWidth + contentMarginWidth, [self getOrginY:point])];
        }
    }];
    lineLayer.strokeColor = self.chartBrokenLineColor.CGColor;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    lineLayer.path = shapePath.CGPath;
    [self.contentShowView.layer addSublayer:lineLayer];
}

#pragma mark 绘制圆点部分
- (void)addPointsLayerToView:(NSArray*)dataArray
{
    [dataArray enumerateObjectsUsingBlock:^(NSString *pointValue, NSUInteger idx, BOOL *stop) {
        float point = [pointValue floatValue];
        float pointOrginX = idx*self.xAxisRangWidth - kPointRadius + contentMarginWidth;
        
        CAShapeLayer *pointLayer2 = [CAShapeLayer layer];
        pointLayer2.contentsScale = [UIScreen mainScreen].scale;
        UIBezierPath *pointPath2 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(pointOrginX - 1, [self getOrginY:point] - kPointBgRadius, kPointBgRadius*2, kPointBgRadius*2) cornerRadius:kPointBgRadius];
        pointLayer2.fillColor = [UIColor whiteColor].CGColor;
        pointLayer2.path = pointPath2.CGPath;
        [self.contentShowView.layer addSublayer:pointLayer2];
        
        CAShapeLayer *pointLayer = [CAShapeLayer layer];
        pointLayer.contentsScale = [UIScreen mainScreen].scale;
        UIBezierPath *pointPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(pointOrginX, [self getOrginY:point] - kPointRadius, kPointRadius*2, kPointRadius*2) cornerRadius:kPointRadius];
        pointLayer.fillColor = self.chartPointColor.CGColor;
        pointLayer.path = pointPath.CGPath;
        [self.contentShowView.layer addSublayer:pointLayer];
    }];
}

- (float)getOrginY:(float)value
{
    float orginY = 0;
    switch (caculateType) {
        case caculateAllPositiveNumberType:
        {
            orginY = xAxisHeight - value*xAxisHeight/totalValue;
        }
            break;
        case caculateAllNegativeType:
        {
            orginY = - value*xAxisHeight/totalValue;
        }
            break;
        case caculateMixtureType:
        {
            float stepValue = (self.maxValue - self.minValue)/(self.stepCount+1);
            value = self.maxValue + stepValue - value;
            orginY = value*xAxisHeight/totalValue;
        }
            break;
            
        default:
            break;
    }
    
    return orginY;
}

- (void)drawDragPointView
{
    self.dragPointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, xAxisHeight+kMarginTopHeight)];
    self.dragPointView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.dragPointView];
    
    CAShapeLayer *pointLayer = [CAShapeLayer layer];
    pointLayer.strokeColor = self.dragPointColor.CGColor;
    pointLayer.fillColor = self.dragPointColor.CGColor;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.dragPointView.frame.size.width, self.dragPointView.frame.size.width) cornerRadius:self.dragPointView.frame.size.width/2];
    [path moveToPoint:CGPointMake(self.dragPointView.frame.size.width/2, 0)];
    [path addLineToPoint:CGPointMake(self.dragPointView.frame.size.width/2, self.dragPointView.frame.size.height)];
    pointLayer.path = path.CGPath;
    
    [self.dragPointView.layer addSublayer:pointLayer];
    
}

#pragma mark 手势操作
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint ticklePoint = [touch locationInView:self];
    [self dragPointView:ticklePoint];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint ticklePoint = [touch locationInView:self];
    [self dragPointView:ticklePoint];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint ticklePoint = [touch locationInView:self];
    [self dragPointView:ticklePoint];
}

- (void)dragPointView:(CGPoint)dragPoint
{
    if (!self.isShowDragPointView) {
        return;
    }
    [self.xAxisPoints enumerateObjectsUsingBlock:^(NSNumber  *xAxisValue, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat xAxis = [xAxisValue floatValue];
        if (fabs(dragPoint.x-kMarginLeftWidth-xAxis)<3) {
            self.dragPointView.center = CGPointMake(xAxis+kMarginLeftWidth, self.dragPointView.center.y);
            if (self.clickDetailDataBlock) {
                self.clickDetailDataBlock(idx);
            }
            *stop = YES;
        }
    }];
}

- (void)dragPointViewMoveToLastData
{
    CGFloat xAxis = [self.xAxisPoints.lastObject floatValue];
    self.dragPointView.center = CGPointMake(xAxis+kMarginLeftWidth, self.dragPointView.center.y);
}
@end
