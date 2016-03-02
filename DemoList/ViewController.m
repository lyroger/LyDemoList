//
//  ViewController.m
//  DemoList
//
//  Created by luoyan on 15/11/12.
//  Copyright © 2015年 luoyan. All rights reserved.
//

#import "ViewController.h"
#import "ChatViewViewController.h"
#import "LYGestureCodeViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableViewList;
    NSArray     *dataArray;
    NSArray     *controllers;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"DemoList";
    [self loadSubView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadSubView
{
    dataArray = @[@"折线图形",
                  @"循环滚动视图",
                  @"搜索框(仿微信)",
                  @"手势密码",
                  @"下载demo",
                  @"timer(NSRunLoopCommonModes)",
                  @"CoreText",
                  @"runtime那些事",
                  @"毛玻璃效果",
                  @"动画那些事",
                  @"MRC模式测试",
                  @"文件预览",
                  @"使用动态库",
                  @"编辑日历事件",
                  @"合成音视频"];
    
    controllers = @[@"ChatViewViewController",
                    @"AdScollViewController",
                    @"LYSearchBarViewController",
                    @"LYGestureCodeViewController",
                    @"DownloadViewController",
                    @"TimerTableViewController",
                    @"CoreTextViewController",
                    @"RunTimeMessageViewController",
                    @"BlurImageViewController",
                    @"AnimationViewController",
                    @"MRCModeViewController",
                    @"DITableViewController",
                    @"DynamicFrameworkViewController",
                    @"CalendarViewController",
                    @"VideoAudioViewController"];
    
    
    tableViewList = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableViewList.delegate = self;
    tableViewList.dataSource = self;
    [tableViewList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"demoListCell"];
    [self.view addSubview:tableViewList];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSString *vcStr = [controllers objectAtIndex:indexPath.row];
    UIViewController *vc = [[NSClassFromString(vcStr) alloc] init];
    
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    animation.duration = 1;
    
    CABasicAnimation *tran = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    tran.duration = 1;
    tran.fromValue = [NSNumber numberWithFloat:0];
    tran.toValue = [NSNumber numberWithFloat:M_PI];
    
    [self.navigationController pushViewController:vc animated:YES];
//    [self.navigationController.view.layer addAnimation:tran forKey:@"an"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"demoListCell"];
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

@end
