//
//  MRCModeViewController.m
//  DemoList
//
//  Created by luoyan on 16/1/13.
//  Copyright © 2016年 luoyan. All rights reserved.
//

#import "MRCModeViewController.h"

@interface MRCModeViewController ()

@end

@implementation MRCModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView* testObj = [[UIView alloc] init];
    [testObj release];
    [testObj setNeedsLayout];
    
    NSString *str = [NSString stringWithFormat:@"%zd",9];
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
