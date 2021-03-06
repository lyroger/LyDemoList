//
//  ChartVIew.m
//  myDemoPro
//
//  Created by luoyan on 14/12/16.
//  Copyright (c) 2014年 mysoft. All rights reserved.
//

#import "ChartView.h"
#import "ChartCanvasView.h"

#define kMarginTopHeight 20

@interface ChartView()
{
    ChartCanvasView *canvasView;
}

@end

@implementation ChartView

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

- (void)loadChartViewWithData:(NSMutableArray*)dataSourceArray
{
    self.dataSourceArray = dataSourceArray;
    [self reloadData];
}

- (void)initData
{
    self.stepCount = 8;
    self.isNeedShadow = YES;
    self.isNeedScoll = NO;
    self.isNeedContentMarginWidth = YES;
    self.backgroundColor = kGreyishWhiteColor;
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
        
        canvasView = [[ChartCanvasView alloc] initWithFrame:CGRectMake(0, kMarginTopHeight, self.frame.size.width, self.frame.size.height-kMarginTopHeight)];
        canvasView.backgroundColor = [UIColor clearColor];
        [self addSubview:canvasView];
    }
    if (self.dataSourceArray.count>0) {
        [canvasView.objectArray removeAllObjects];
        [canvasView.objectArray addObjectsFromArray:self.dataSourceArray];
    }
    canvasView.verticalLineCount = self.verticalLineCount==0?5:self.verticalLineCount;
    canvasView.yUnit = self.yUnit;
    canvasView.xUnit = self.xUnit;
    canvasView.stepCount = self.stepCount;
    canvasView.isNeedShadow = self.isNeedShadow;
    canvasView.isNeedScroll = self.isNeedScoll;
    canvasView.isNeedContentMarginWidth = self.isNeedContentMarginWidth;
    [canvasView reloadData];
}

@end
