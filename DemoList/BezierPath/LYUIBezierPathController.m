//
//  LYUIBezierPathController.m
//  DemoList
//
//  Created by luoyan on 2018/1/9.
//  Copyright © 2018年 luoyan. All rights reserved.
//

#import "LYUIBezierPathController.h"

@interface LYUIBezierPathController ()

@property (nonatomic, strong) CALayer *maskLayer;
@property (nonatomic, strong) UIImageView *backView;
@end

@implementation LYUIBezierPathController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self drawLayer];
    self.contentView.ly_cancelTouchInviewValue = YES;
    [self.contentView addSubview:self.backView];
    // Do any additional setup after loading the view.
}

- (void)drawLayer
{
    UIBezierPath *path = [UIBezierPath bezierPath];

//    [path moveToPoint:CGPointMake(200, 200)];
//    [path addArcWithCenter:CGPointMake(150, 200) radius:50 startAngle:0 endAngle:2*M_PI clockwise:YES];
//    [path moveToPoint:CGPointMake(250, 200)];
//    [path addArcWithCenter:CGPointMake(150, 200) radius:100 startAngle:0 endAngle:2*M_PI clockwise:YES];
//    [path moveToPoint:CGPointMake(300, 200)];
//    [path addArcWithCenter:CGPointMake(150, 200) radius:150 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    
    CGFloat maxWidth = CGRectGetWidth(self.view.frame);
    CGFloat maxHeight = CGRectGetHeight(self.view.frame);
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(maxWidth, 0)];
    [path addLineToPoint:CGPointMake(maxWidth, maxHeight)];
    [path addLineToPoint:CGPointMake(0, maxHeight)];
    [path addLineToPoint:CGPointMake(0, 0)];
    
    CGFloat frameWidth = 240;
    CGFloat frameHeith = 260;
    
    [path moveToPoint:CGPointMake((maxWidth-frameWidth)/2, (maxHeight-frameHeith)/2)];
    [path addLineToPoint:CGPointMake((maxWidth-frameWidth)/2 + frameWidth, (maxHeight-frameHeith)/2)];
    [path addLineToPoint:CGPointMake((maxWidth-frameWidth)/2 + frameWidth, (maxHeight-frameHeith)/2 + frameHeith)];
    [path addLineToPoint:CGPointMake((maxWidth-frameWidth)/2, (maxHeight-frameHeith)/2 + frameHeith)];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor blueColor].CGColor;
    shapeLayer.fillRule = kCAFillRuleEvenOdd;
    
//    fillRule 的作用
//    kCAFillRuleEvenOdd   奇偶，判断某点是否在区域内，可从该点任意方向出发花一条射线，若与路径的交点数为奇数则在区域内，否则在外部，外部的不会画图。
//    kCAFillRuleNonZero   非零判断，判断某点是否在区域内，可从该点任意方向出发画一条射线，若路径从左到右与该射线相交则+1，相反则-1，初始值为0，若结果为0则在外部，否则在内部。

    shapeLayer.lineWidth = 3;
    shapeLayer.lineJoin = kCALineJoinBevel;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    shapeLayer.contentsScale = [UIScreen mainScreen].scale;
    
    [self.contentView.layer addSublayer:shapeLayer];
}

- (CALayer*)maskLayer
{
    if (!_maskLayer) {
        _maskLayer = [CALayer layer];
        _maskLayer.frame = CGRectMake(0, 0, 100, 100);
        _maskLayer.backgroundColor = [UIColor grayColor].CGColor;
        _maskLayer.cornerRadius = 50;
    }
    return _maskLayer;
}

- (UIView*)backView
{
    if (!_backView) {
        _backView = [UIImageView new];
        _backView.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame));
        _backView.image = [UIImage imageNamed:@"WID-small.jpg"];
        self.backView.layer.mask = self.maskLayer;
        self.backView.hidden = YES;
    }
    return _backView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.backView.hidden = NO;
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self.backView];
    
    //关闭隐式动画，不然感觉移动反应迟钝
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.maskLayer.position = CGPointMake(point.x, point.y - 50/*上移一点点，防止手挡住视图*/);
    [CATransaction commit];
    
    NSLog(@"touchedBegan");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1.获取手指对象
    UITouch *touch = [touches anyObject];
    //2.获取手指当前位置
    CGPoint currentPoint = [touch locationInView:self.backView];
    //3.获取手指之前的位置
    CGPoint previousPoint = [touch previousLocationInView:self.backView];
    
    //4.计算移动的增量
    CGFloat dx = currentPoint.x - previousPoint.x;
    CGFloat dy = currentPoint.y - previousPoint.y;
    //修改视图位置
    
    //关闭隐式动画，不然感觉移动反应迟钝
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.maskLayer.position = CGPointMake(self.maskLayer.position.x + dx, self.maskLayer.position.y + dy);
    [CATransaction commit];
    
    NSLog(@"touchesMoved");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.backView.hidden = YES;
    NSLog(@"touchesEnded");
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.backView.hidden = YES;
    NSLog(@"touchesCancelled");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
