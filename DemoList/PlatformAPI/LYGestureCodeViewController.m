//
//  LYGestureCodeViewController.m
//  DemoList
//
//  Created by luoyan on 15/12/4.
//  Copyright © 2015年 luoyan. All rights reserved.
//

#import "LYGestureCodeViewController.h"
#import "MYGestureUnlockViewController.h"

@interface LYGestureCodeViewController ()

@end

@implementation LYGestureCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [self showGestureCode];
    // Do any additional setup after loading the view.
}

//退出应用
- (void)didEnterBackground
{
    if (![MYGestureUnlockViewController isGestureLockShowing]) {
        [MYGestureUnlockViewController showGestureUnlockViewWithEnterBlock:^{
            
        }];
    }
}

- (void)showGestureCode
{
    [MYGestureUnlockViewController showGestureUnlockViewWithEnterBlock:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
