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
    dataArray = @[@"折线图形",@"循环滚动视图",@"搜索框(仿微信)",@"手势密码"];
    controllers = @[@"ChatViewViewController",@"AdScollViewController",@"LYSearchBarViewController",@"LYGestureCodeViewController"];
    
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
    [self.navigationController pushViewController:vc animated:YES];
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
