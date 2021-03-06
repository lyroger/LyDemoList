//
//  LYMainTabBarController.m
//  DemoList
//
//  Created by luoyan on 2017/6/20.
//  Copyright © 2017年 luoyan. All rights reserved.
//

#import "LYMainTabBarController.h"
#import "LYControlsViewController.h"
#import "LYAnimationsViewController.h"
#import "LYVideoImageViewController.h"
#import "LYOthersViewController.h"
#import "LYDrawsViewController.h"
#import "LYBaseNavigationController.h"


@interface LYMainTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic,assign) CGRect tabbarViewOriginFrame;
@property (nonatomic,strong) UIView *superTabbarView;

@end

@implementation LYMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self enterMainView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)enterMainView
{
    LYControlsViewController *controlVC = [[LYControlsViewController alloc] init];
    LYBaseNavigationController *controlNav = [[LYBaseNavigationController alloc] initWithRootViewController:controlVC];

    LYAnimationsViewController *animationVC = [[LYAnimationsViewController alloc] init];
    LYBaseNavigationController *animationNav = [[LYBaseNavigationController alloc] initWithRootViewController:animationVC];

    LYDrawsViewController *drawVC = [[LYDrawsViewController alloc] init];
    LYBaseNavigationController *drawNav = [[LYBaseNavigationController alloc] initWithRootViewController:drawVC];

    LYVideoImageViewController *videoImageVC = [[LYVideoImageViewController alloc] init];
    LYBaseNavigationController *videoImageNav = [[LYBaseNavigationController alloc] initWithRootViewController:videoImageVC];
    
    LYOthersViewController *otherVC = [[LYOthersViewController alloc] init];
    LYBaseNavigationController *otherNav = [[LYBaseNavigationController alloc] initWithRootViewController:otherVC];
//    otherNav.view.backgroundColor = [UIColor blackColor];
    [self createWithArrayViewControllers:@[controlNav, animationNav, drawNav, videoImageNav, otherNav]
                        arrayImageNormal:@[@"icon_tab_home", @"icon_tab_work",@"icon_tab_home",@"icon_tab_estate", @"icon_tab_me"]
                        arrayImageSelect:@[@"icon_tab_home_tap", @"icon_tab_work_tap",@"icon_tab_home_tap", @"icon_tab_estate_tap" , @"icon_tab_me_tap"]
                              arrayTitle:@[@"控件", @"动画",@"绘图" ,@"视频文件" ,@"其他"]];
}

/*
 自定义TabBar方法
 */
- (void)createWithArrayViewControllers:(NSArray *)viewControllers
                      arrayImageNormal:(NSArray *)arrayImageNor
                      arrayImageSelect:(NSArray *)arrayImageSel
                            arrayTitle:(NSArray *)arrayTitle
{
    self.viewControllers = viewControllers;
    [self.tabBar setSelectedImageTintColor:kMainColor];
    self.tabBar.tintColor = kMainColor;
    self.tabBar.barTintColor = [UIColor whiteColor];
    
    //修改tabbar顶部上的一条黑线
    CGRect rect = CGRectMake(0, 0, mScreenWidth, 49);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setBackgroundImage:img];
    [self.tabBar setShadowImage:img];
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    self.delegate = self;
    
    //用自己的颜色
    self.tabBar.layer.borderWidth = 0.5;
    self.tabBar.layer.borderColor = UIColorHex(0xCCCCCC).CGColor;
    
    for (int i = 0; i < self.viewControllers.count; i++)
    {
        UIViewController *vc = self.viewControllers[i];
        NSString *title = arrayTitle[i];
        UIImage *imageNor = [UIImage imageNamed:arrayImageNor[i]];
        UIImage *imageSel = [UIImage imageNamed:arrayImageSel[i]];
        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:imageNor selectedImage:imageSel];
        //调整tabbar的title与图片之间的间距
        [vc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -2.0)];
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"selectedIndex = %zd",tabBarController.selectedIndex);
}

- (void)switchTabBarToRootViewVC:(LYBaseViewController*)rootView
{
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    self.tabbarViewOriginFrame = self.tabBar.frame;
    self.superTabbarView = self.tabBar.superview;
    [self.tabBar removeFromSuperview];
    self.tabBar.frame = CGRectMake(0, screenHeight-self.tabBar.frame.size.height, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
    [rootView.view addSubview:self.tabBar];
}

- (void)switchTabBarToTabBarVC
{
    [self.tabBar removeFromSuperview];
    self.tabBar.frame = self.tabbarViewOriginFrame;
    [self.superTabbarView addSubview:self.tabBar];
}

@end
