//
//  LYSearchBarViewController.m
//  DemoList
//
//  Created by luoyan on 15/12/4.
//  Copyright © 2015年 luoyan. All rights reserved.
//

#import "LYSearchBarViewController.h"
#import "AdScollViewController.h"
#import "LYSearchDisplayController.h"
#import "LYSearchBar.h"

@interface LYSearchBarViewController ()<UISearchDisplayDelegate,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    LYSearchBar *mySearchBar;
    LYSearchDisplayController *searchDisplayController;
    UITableView *tableViewList;
    
    NSArray *dataArray;
    NSArray *searchDataArray;
    
}
@end

@implementation LYSearchBarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"search";
    [self loadSubView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)loadSubView
{
    dataArray = @[@"第一行",@"第二行",@"第三行",@"第四行",@"第五行"];
    self.view.backgroundColor = GreyishWhiteColor;
    searchDataArray = @[@"搜索第一行"];    
    
    mySearchBar = [[LYSearchBar alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, 44)];
    mySearchBar.delegate = self;
    
    
    searchDisplayController = [[LYSearchDisplayController alloc] initWithSearchBar:mySearchBar contentsController:self];
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [searchDisplayController.searchResultsTableView setTableFooterView:view];
    [searchDisplayController.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    tableViewList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, self.view.frame.size.height-50-64) style:UITableViewStyleGrouped];
    tableViewList.backgroundColor = [UIColor clearColor];
    tableViewList.tableHeaderView = mySearchBar;
    tableViewList.tableFooterView = view;
    tableViewList.delegate = self;
    tableViewList.dataSource = self;
    [tableViewList setContentOffset:CGPointMake(0, tableViewList.tableHeaderView.frame.size.height)];
    [tableViewList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableViewList];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:tableViewList]) {
        
    } else {
        AdScollViewController *adVC = [[AdScollViewController alloc] init];
        [self.navigationController pushViewController:adVC animated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:tableViewList]) {
        return dataArray.count;
    } else {
        return searchDataArray.count;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if ([tableView isEqual:tableViewList]) {
        cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [searchDataArray objectAtIndex:indexPath.row];
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
