//
//  TimerTableViewController.m
//  DemoList
//
//  Created by luoyan on 15/12/28.
//  Copyright © 2015年 luoyan. All rights reserved.
//

#import "TimerTableViewController.h"

@interface TimerTableViewController ()
{
    NSMutableArray *dataArray;
    NSInteger       timerIndex;
}

@end

@implementation TimerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self initData];
    [self initTimer];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)timerTick:(NSTimer*)timer
{
    timerIndex ++;
    self.title = [NSString stringWithFormat:@"%zd",timerIndex];
}

- (void)initTimer
{
//    [NSTimer scheduledTimerWithTimeInterval:1.0
//                                     target:self
//                                   selector:@selector(timerTick:)
//                                   userInfo:nil
//                                    repeats:YES];
    
    //然后再添加到NSRunLoopCommonModes里  添加到NSRunLoopCommonModes 后，timer将不受阻塞
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(timerTick:)
                                           userInfo:nil
                                            repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)initData
{
    timerIndex = 1;
    dataArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i<1000; i++) {
        [dataArray addObject:[NSString stringWithFormat:@"这是第%zd",i]];
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark DEMO来源

/*
 30. 以+ scheduledTimerWithTimeInterval...的方式触发的timer，在滑动页面上的列表时，timer会暂定回调，为什么？如何解决？
 
 RunLoop只能运行在一种mode下，如果要换mode，当前的loop也需要停下重启成新的。利用这个机制，ScrollView滚动过程中NSDefaultRunLoopMode（kCFRunLoopDefaultMode）的mode会切换到UITrackingRunLoopMode来保证ScrollView的流畅滑动：只能在NSDefaultRunLoopMode模式下处理的事件会影响scrllView的滑动。
 
 如果我们把一个NSTimer对象以NSDefaultRunLoopMode（kCFRunLoopDefaultMode）添加到主运行循环中的时候, ScrollView滚动过程中会因为mode的切换，而导致NSTimer将不再被调度。
 
 同时因为mode还是可定制的，所以：
 
 Timer计时会被scrollView的滑动影响的问题可以通过将timer添加到NSRunLoopCommonModes（kCFRunLoopCommonModes）来解决。代码如下：
     [NSTimer scheduledTimerWithTimeInterval:1.0
                                      target:self
                                    selector:@selector(timerTick:)
                                    userInfo:nil
                                     repeats:YES];
     
     //然后再添加到NSRunLoopCommonModes里  添加到NSRunLoopCommonModes 后，timer将不受阻塞
     NSTimer *timer = [NSTimer timerWithTimeInterval:1.0
     target:self
     selector:@selector(timerTick:)
     userInfo:nil
     repeats:YES];
     [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];


*/

@end
