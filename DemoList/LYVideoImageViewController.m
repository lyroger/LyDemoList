//
//  LYVideoImageViewController.m
//  DemoList
//
//  Created by luoyan on 2017/6/20.
//  Copyright © 2017年 luoyan. All rights reserved.
//

#import "LYVideoImageViewController.h"

@interface LYVideoImageViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableViewList;
    NSArray     *dataArray;
    NSArray     *controllers;
}

@end

@implementation LYVideoImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频文件";
    [self loadSubView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadSubView
{
    dataArray = @[@"毛玻璃效果",
                  @"文件预览",
                  @"合成音视频",
                  @"黑白图片处理",
                  @"音频播放"];
    
    controllers = @[@"BlurImageViewController",
                    @"DITableViewController",
                    @"VideoAudioViewController",
                    @"ShowcaseFilterListController",
                    @"LYAudioPalyerViewController"];
    
    
    tableViewList = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStyleGrouped];
    tableViewList.backgroundColor = [UIColor whiteColor];
    tableViewList.delegate = self;
    tableViewList.dataSource = self;
    [tableViewList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"demoListCell"];
    [self.contentView addSubview:tableViewList];
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
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
@end
