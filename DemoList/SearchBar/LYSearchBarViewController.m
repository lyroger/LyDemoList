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

@interface LYSearchBarViewController ()<UISearchDisplayDelegate,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
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

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //代理置空，否则会闪退
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //开启iOS7的滑动返回效果
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        //只有在二级页面生效
        if ([self.navigationController.viewControllers count] == 2) {
            self.navigationController.interactivePopGestureRecognizer.delegate = self;
        }
    }
}

- (void)navigationcontrollerSetWithTranslucent:(BOOL)isTranslucent
{
    if (isTranslucent) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.translucent = YES;
    }else{
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:mainColor size:CGSizeMake(1, 1)] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.translucent = NO;
    }
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context,
                                   
                                   color.CGColor);
    
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
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
        AdScollViewController *adVC = [[AdScollViewController alloc] init];
        [self.navigationController pushViewController:adVC animated:YES];
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
