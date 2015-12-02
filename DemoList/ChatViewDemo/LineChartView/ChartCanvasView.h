//
//  ChartCanvasView.h
//  myDemoPro
//
//  Created by luoyan on 14/12/17.
//  Copyright (c) 2014年 mysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

//定义距离
#define kMarginBottomHeight     40
#define kMarginLeftWidth        35
#define kMarginRightWidth       25
#define kMarginTopHeight        20
#define kPointRadius            2
#define kPointBgRadius          3
#define kXAxisFontSize          10



//定义颜色
#define kChartViewLineColor     [UIColor colorWithRed:0xe6/255.0 green:0xe6/255.0 blue:0xe6/255.0 alpha:1.0]
#define kChartViewTextColor     [UIColor colorWithRed:0x9b/255.0 green:0x9b/255.0 blue:0x9b/255.0 alpha:1.0]

typedef void(^ClickDetailData)(NSInteger dataIndex);
@interface ChartCanvasView : UIView

@property (nonatomic,assign) NSInteger stepCount;
@property (nonatomic,strong) NSMutableArray *objectArray;
@property (nonatomic,assign) BOOL isNeedContentMarginWidth;
@property (nonatomic,strong) NSString *yUnit;
@property (nonatomic,strong) NSString *xUnit;
@property (nonatomic,assign) NSInteger verticalLineCount;
@property (nonatomic,strong) UIColor *chartBrokenLineColor;
@property (nonatomic,strong) UIColor *chartPointColor;
@property (nonatomic,strong) UIColor *dragPointColor;
@property (nonatomic,assign) BOOL   isShowDragPointView;

@property (nonatomic,strong) ClickDetailData clickDetailDataBlock;

- (void)reloadData;
@end
