//
//  ChatViewViewController.m
//  DemoList
//
//  Created by luoyan on 15/11/12.
//  Copyright © 2015年 luoyan. All rights reserved.
//

#import "ChatViewViewController.h"
#import "LineChartView.h"
#import "ChartViewDataSource.h"

@interface ChatViewViewController ()

@end

@implementation ChatViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"折线图";
    [self loadChatView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadChatView
{
    UILabel *labelShowTips = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, mScreenWidth, 25)];
    labelShowTips.textColor = mainColor;
    labelShowTips.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelShowTips];
    
    LineChartView *chatV = [[LineChartView alloc] initWithFrame:CGRectMake(10, 120, mScreenWidth-10*2, 200)];
    chatV.stepCount = 10;
    chatV.verticalLineCount = 8;
    chatV.yUnit = @"mmHg";
    chatV.chartBrokenLineColor = [UIColor redColor];
    chatV.isShowDragPointView = YES;
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i<12; i++) {
        NSInteger yValue = i%2==0?(i+8):(i+10);
        NSDictionary *info = @{@"yValue":[NSString stringWithFormat:@"%zd",yValue],
                               @"xValue":[NSString stringWithFormat:@"11-%zd",i+1]};
        [dataArray addObject:info];
    }
    
//    NSMutableArray *dataArray1 = [[NSMutableArray alloc] init];
//    for (int i = 0; i<12; i++) {
//        NSInteger yValue = i%2==0?(i+8):(i+10);
//        yValue = 50-yValue;
//        NSDictionary *info = @{@"yValue":[NSString stringWithFormat:@"%zd",yValue],
//                               @"xValue":[NSString stringWithFormat:@"11-%zd",i+1]};
//        [dataArray1 addObject:info];
//    }
    
//    NSArray *dataSourceArray = @[dataArray,dataArray1];
    NSArray *dataSourceArray = @[dataArray];
    chatV.viewDetailPointDataBlock = ^(NSInteger dataIndex){
        NSArray *data = [dataSourceArray objectAtIndex:0];
        NSDictionary *info = [data objectAtIndex:dataIndex];
        labelShowTips.text = [info objectForKey:@"yValue"];
    };
    [chatV loadChartViewWithData:dataSourceArray];
    
    [self.view addSubview:chatV];
}

@end
