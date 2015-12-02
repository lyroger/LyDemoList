//
//  LineChartView.h
//  myDemoPro
//
//  Created by luoyan on 14/12/16.
//  Copyright (c) 2014年 mysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ViewDetailPointData)(NSInteger dataIndex);
@protocol LineChartViewDataSource;

@interface LineChartView : UIView

@property (nonatomic, assign) id<LineChartViewDataSource> dataSource;
@property (nonatomic, strong) ViewDetailPointData   viewDetailPointDataBlock;

#pragma ChartView Property

/**
 *  是否显示拖动指针
 */
@property (nonatomic,assign) BOOL   isShowDragPointView;

/**
 *  拖动指针背景色;
 */
@property (nonatomic,strong) UIColor *dragPointColor;

/**
 *  折线的背景色
 */
@property (nonatomic,strong) UIColor *chartBrokenLineColor;

/**
 *  折线图折点圆点的颜色，若不设置则为折线的颜色
 */
@property (nonatomic,strong) UIColor *chartPointColor;

/**
 *  图形上的内容是否需要与Y轴保持一点距离。 defualt 为 YES
 */
@property (nonatomic,assign) BOOL isNeedContentMarginWidth;

/**
 *  网格的个数  defualt 为 8  ps:负数和正数同时存在时，网格会多一个；
 */
@property (nonatomic,assign) NSInteger stepCount;

/**
 *  竖直方向的线条数
 */
@property (nonatomic,assign) NSInteger verticalLineCount;

/**
 *  ChartView的数据源；
 */
@property (nonatomic,strong) NSArray *dataSourceArray;

/**
 *  y轴上的单位
 */
@property (nonatomic,strong) NSString *yUnit;

/**
 *  x轴上的单位
 */
@property (nonatomic,strong) NSString *xUnit;
#pragma ChartView Method
/**
 *  加载ChartView
 *
 *  @param dataSourceArray ChartView的数据源
 */
- (void)loadChartViewWithData:(NSArray*)dataSourceArray;
@end

@protocol LineChartViewDataSource <NSObject>

- (NSInteger)numberOfSectionInChatView:(LineChartView*)chartView;

- (NSInteger)chartView:(LineChartView *)chartView numberOfRowsInSection:(NSInteger)section;

@end
