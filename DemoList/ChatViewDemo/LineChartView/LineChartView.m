//
//  LineChartView.m
//  myDemoPro
//
//  Created by luoyan on 14/12/16.
//  Copyright (c) 2014年 mysoft. All rights reserved.
//

#import "LineChartView.h"
#import "ChartCanvasView.h"

@interface LineChartView()
{
    ChartCanvasView *canvasView;
}

@end

@implementation LineChartView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)loadChartViewWithData:(NSArray*)dataSourceArray
{
    self.dataSourceArray = dataSourceArray;
    [self reloadData];
}

- (void)initData
{
    self.stepCount = 5;
    self.isNeedContentMarginWidth = YES;
    self.backgroundColor = [UIColor whiteColor];
}

- (void)reloadData
{
    if (canvasView) {
        [canvasView removeFromSuperview];
        canvasView = nil;
    }
    if (!canvasView) {
        UIView *placeHolderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 10)];
        placeHolderView.backgroundColor = [UIColor clearColor];
        [self addSubview:placeHolderView];
        
        canvasView = [[ChartCanvasView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        canvasView.backgroundColor = [UIColor clearColor];
        [self addSubview:canvasView];
    }
    if (self.dataSourceArray.count>0) {
        [canvasView.objectArray removeAllObjects];
        [canvasView.objectArray addObjectsFromArray:self.dataSourceArray];
    }
    
    //设置折线背景色
    if (self.chartBrokenLineColor) {
        canvasView.chartBrokenLineColor = self.chartBrokenLineColor;
    } else {
        canvasView.chartBrokenLineColor = mainColor;
    }
    //设置折线圆点背景色
    if (self.chartPointColor) {
        canvasView.chartPointColor = self.chartPointColor;
    } else {
        canvasView.chartPointColor = canvasView.chartBrokenLineColor;
    }
    
    if (self.dragPointColor) {
        canvasView.dragPointColor = self.dragPointColor;
    } else {
        canvasView.dragPointColor = mainColor;
    }
    
    __weak LineChartView *weakSelf = self;
    canvasView.clickDetailDataBlock = ^(NSInteger dataIndex){
        if (weakSelf.viewDetailPointDataBlock) {
            weakSelf.viewDetailPointDataBlock(dataIndex);
        }
    };
    canvasView.isShowDragPointView = self.isShowDragPointView;
    canvasView.verticalLineCount = self.verticalLineCount == 0 ? 5: self.verticalLineCount;
    canvasView.yUnit = self.yUnit;
    canvasView.xUnit = self.xUnit;
    canvasView.stepCount = self.stepCount;
    canvasView.isNeedContentMarginWidth = self.isNeedContentMarginWidth;
    [canvasView reloadData];
}

@end
