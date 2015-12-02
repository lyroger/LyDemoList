//
//  ChartCanvasView.h
//  myDemoPro
//
//  Created by luoyan on 14/12/17.
//  Copyright (c) 2014年 mysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

//定义距离
#define kMarginTopHeight        40
#define kMarginBottomHeight     40
#define kMarginLeftWidth        40
#define kMarginRightWidth       20
#define kPointRadius            2.5
#define kXAxisFontSize          10


//定义颜色
#define kRGBColor(r, g, b)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define kGreyishGreenColor    kRGBColor(26, 188, 156)
#define kGreyishWhiteColor    kRGBColor(242, 242, 242)
#define kGrayWhiteColor       kRGBColor(200, 200, 200)
#define kTextColor            [UIColor blackColor]
#define kAxisBackgroundColor  kGrayWhiteColor

@interface ChartCanvasView : UIView

@property (nonatomic,assign) NSInteger stepCount;
@property (nonatomic,assign) BOOL isNeedScroll;
@property (nonatomic,strong) NSMutableArray *objectArray;
@property (nonatomic,assign) BOOL isNeedShadow;
@property (nonatomic,assign) BOOL isNeedContentMarginWidth;
@property (nonatomic,strong) NSString *yUnit;
@property (nonatomic,strong) NSString *xUnit;
@property (nonatomic,assign) NSInteger verticalLineCount;
- (void)reloadData;
@end
