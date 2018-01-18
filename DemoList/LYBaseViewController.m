//
//  LYBaseViewController.m
//  DemoList
//
//  Created by luoyan on 2017/6/20.
//  Copyright © 2017年 luoyan. All rights reserved.
//

#import "LYBaseViewController.h"
#import "LYNavgationBarView.h"


@interface LYBaseViewController ()

@property (nonatomic,strong) LYNavgationBarView *navgationView;
@end

@implementation LYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kNavgationColor;
    // Do any additional setup after loading the view.
    self.navgationView = [[LYNavgationBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kNavgationHeight)];
    
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.navgationView];
    if (self.navigationController.viewControllers.count == 1) {
        [self.navgationView hideBackButton:YES];
    } else {
        [self.navgationView hideBackButton:NO];
        __weak LYBaseViewController *weakSelf = self;
        self.navgationView.backBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
}

- (UIView*)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavgationHeight, self.view.frame.size.width, self.view.frame.size.height-kNavgationHeight)];
        _contentView.backgroundColor = kBackgroundColor;
    }
    return _contentView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    [self.navgationView title:title];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createNavgationBar
{
//    self.view.safeAreaInsets
    
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
