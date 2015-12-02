//
//  ChartViewDataSource.m
//  DemoList
//
//  Created by luoyan on 15/11/13.
//  Copyright © 2015年 luoyan. All rights reserved.
//

#import "ChartViewDataSource.h"
#import "LineChartView.h"

@interface ChartViewDataSource()
{
    
}

@property (nonatomic,strong) NSArray *dataArr;
@end

@implementation ChartViewDataSource
- (id)initDataSourceWithArray:(NSArray*)dataArr
{
    if (self = [super init]) {
        self.dataArr = dataArr;
    }
    return self;
}

- (NSInteger)numberOfSectionInChatView:(LineChartView*)chartView
{
    return self.dataArr.count?self.dataArr.count:1;
}

- (NSInteger)chartView:(LineChartView *)chartView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArr.count>=section) {
        NSDictionary *dataInfo = [self.dataArr objectAtIndex:section];
        return [[dataInfo objectForKey:@"data"] count];
    }
    return 0;
}
@end
