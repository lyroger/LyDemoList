//
//  CoreTextViewController.m
//  DemoList
//
//  Created by luoyan on 15/12/30.
//  Copyright © 2015年 luoyan. All rights reserved.
//

#import "CoreTextViewController.h"
#import "CTDisplayView.h"

@interface CoreTextViewController ()
{
    CTDisplayView *displayview;
}
@end

@implementation CoreTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    displayview = [[CTDisplayView alloc] initWithFrame:CGRectMake(0, 64, mScreenWidth, mScreenHeight-64)];
    [self.view addSubview:displayview];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 300, 80, 40);
    [btn addTarget:self action:@selector(btnClickAction) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"收动调用drawrect" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnClickAction
{
    [displayview drawRect:displayview.bounds];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
