//
//  LYTestViewController.m
//  DemoList
//
//  Created by luoyan on 2018/1/9.
//  Copyright © 2018年 luoyan. All rights reserved.
//

#import "LYTestViewController.h"

@interface LYTestViewController ()

@end

@implementation LYTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[@"www.baidu.com"] applicationActivities:nil];
    [self.navigationController presentViewController:activityVC animated:YES completion:nil];
    // Do any additional setup after loading the view.
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
