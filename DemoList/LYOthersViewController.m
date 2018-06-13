//
//  LYOthersViewController.m
//  DemoList
//
//  Created by luoyan on 2017/6/20.
//  Copyright © 2017年 luoyan. All rights reserved.
//

#import "LYOthersViewController.h"
#import "LYDIYAnimator.h"
#import "LYDIYPopTransition.h"
#import "LYDIYPushTransition.h"

@interface LYOthersViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>
{
    UITableView *tableViewList;
    NSArray     *dataArray;
    NSArray     *controllers;
}

@end

@implementation LYOthersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"其他";
    [self loadSubView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadSubView
{
    dataArray = @[@"手势密码",
                  @"下载demo",
                  @"timer(NSRunLoopCommonModes)",
                  @"runtime那些事",
                  @"MRC模式测试",
                  @"使用动态库",
                  @"编辑日历事件",
                  @"MotionEffect",
                  @"LYTestDemos",
                  @"自定义转场动画",
                  @"评论"];
    
    controllers = @[@"LYGestureCodeViewController",
                    @"DownloadViewController",
                    @"TimerTableViewController",
                    @"RunTimeMessageViewController",
                    @"MRCModeViewController",
                    @"DynamicFrameworkViewController",
                    @"CalendarViewController",
                    @"LYMotionEffectVC",
                    @"LYTestViewController",
                    @"LYDIYTransitionViewController",
                    @"LYCommentViewController"];
    
    
    
    tableViewList = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStyleGrouped];
    tableViewList.backgroundColor = [UIColor whiteColor];
    tableViewList.delegate = self;
    tableViewList.dataSource = self;
    [tableViewList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"demoListCell"];
    [self.contentView addSubview:tableViewList];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *vcStr = [controllers objectAtIndex:indexPath.row];
    UIViewController *vc = [[NSClassFromString(vcStr) alloc] init];
    vc.title = [dataArray objectAtIndex:indexPath.row];
    
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    animation.duration = 1;
    
    CABasicAnimation *tran = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    tran.duration = 1;
    tran.fromValue = [NSNumber numberWithFloat:0];
    tran.toValue = [NSNumber numberWithFloat:M_PI];
    
    //    vc.transitioningDelegate = animator;
    
    //    [self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
    //    [self.navigationController.view.layer addAnimation:tran forKey:@"an"];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
@end
