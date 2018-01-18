//
//  MYGestureUnlockViewController.m
//  MobilePlatform
//
//  Created by Simon Dai on 5/15/14.
//  Copyright (c) 2014 Mysoft. All rights reserved.
//

#import "MYGestureUnlockViewController.h"
#import "MYGestureCodeView.h"
#import "MYGestureTipView.h"
#import "MYPlatformPrivateAPI.h"

#define kPlatformResourceBundle                     @"APIResource.bundle"

static BOOL IsGestureLockShowing;
static MYGestureUnlockViewController *gestureCodeVC = nil;
static BOOL IsKeyboardDidShowing;

@interface MYGestureUnlockViewController () <MYGestureCodeViewDelegate> {
    MYGestureTipView *tipView;
    UILabel *tipLabel;
    UILabel *tipAlertLabel;
    int errorCount;  //剩余错误次数
    UIButton *forgetButton;
}

@property (nonatomic,strong) MYGestureCodeUnLockEnterBlock enter;

- (void)dealUnlock:(MYGestureCodeView *)codeView; //处理解锁的问题

@end

@implementation MYGestureUnlockViewController

+ (void)initialize
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleKeyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleKeyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

+ (void)handleKeyboardDidShow:(NSNotification *)notification
{
    IsKeyboardDidShowing = YES;
}

+ (void)handleKeyboardDidHide:(NSNotification *)notification
{
    IsKeyboardDidShowing = NO;
}

+ (BOOL)isGestureLockShowing {
    return IsGestureLockShowing;
}

+ (void)showGestureUnlockViewWithEnterBlock:(MYGestureCodeUnLockEnterBlock)enter {
    [self showGestureUnlockView:YES enterBlock:enter];
}

+ (void)removeGestureUnlockView {
    [self showGestureUnlockView:NO enterBlock:gestureCodeVC.enter];
}

+ (void)showGestureUnlockView:(BOOL)show enterBlock:(MYGestureCodeUnLockEnterBlock)enter {
    
    static UINavigationController *nav = nil;
    
    static BOOL windowInteractionEnabled;
    static BOOL windowHidden;
    
    if (show) {
        if (!gestureCodeVC) {
            gestureCodeVC = [[MYGestureUnlockViewController alloc] init];
            gestureCodeVC.enter = enter;
        }
        
        if (!nav) {
            nav = [[UINavigationController alloc] init];
            nav.navigationBar.barStyle = UIBarStyleBlack;
        }
        [nav setViewControllers:[NSArray arrayWithObject:gestureCodeVC]];
        nav.view.frame = [UIScreen mainScreen].bounds;
        
//        UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
//        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
        if (!IsKeyboardDidShowing)
        {
            window = [[UIApplication sharedApplication] keyWindow];
        }
        windowInteractionEnabled = window.userInteractionEnabled;
        windowHidden = window.hidden;
        
        window.hidden = NO;
        window.userInteractionEnabled = YES;
        window.tag = 0x3212;
        if (![window isEqual:[nav.view superview]]) {
            [window addSubview:nav.view];
        }
        IsGestureLockShowing = YES;
    } else {
        UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
        if ([[UIApplication sharedApplication] keyWindow] != window && window.tag == 0x3212) {
            window.hidden = windowHidden;
            window.userInteractionEnabled = windowInteractionEnabled;
        }
        [[nav view] removeFromSuperview];
        nav = nil;
        if (gestureCodeVC.enter) {
            gestureCodeVC.enter();
            gestureCodeVC.enter = nil;
        }
        gestureCodeVC = nil;
        IsGestureLockShowing = NO;
        
    }
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"解锁";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor colorWithRed:0/255.0f green:100/255.0f blue:158/255.0f alpha:1.0f];
    [self.navigationController setNavigationBarHidden:YES];
//    if ([[UIDevice currentDevice].systemVersion floatValue]>=6.0) {
//        if ([self.navigationController.navigationBar respondsToSelector:@selector(setShadowImage:)]) {
//            [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
//        }
//    }
//    
//    if (([UIDevice currentDevice].systemVersion.floatValue >= 7.0)) {
//        self.navigationController.navigationBar.translucent = NO;
//        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:25/255.0f green:25/255.0f blue:25/255.0f alpha:1.0f];
//    } else {
//        NSString *imageName = [NSString stringWithFormat:@"%@/%@",kPlatformResourceBundle,@"navbar.png"];
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:imageName]
//                                                      forBarMetrics:UIBarMetricsDefault];
//    }
    
//    MYGestureCodeView *v = [[MYGestureCodeView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 240)/2.0, isIphone5?130:100, 240, 240)];
    MYGestureCodeView *v = [[MYGestureCodeView alloc] initWithFrame:CGRectInset(self.view.frame, (self.view.frame.size.width - 270)/2.0, (self.view.frame.size.height - 270)/2.0)];
    v.frame = CGRectOffset(v.frame, 0, 50);
    [v setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
    v.backgroundColor = [UIColor clearColor];
    v.strokeColor = [UIColor colorWithRed:30/255.0f green:230/255.0f blue:230/255.0f alpha:1.0f];
    v.itemBackgroundImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@",kPlatformResourceBundle,@"GesturesCircle_iPhone.png"]];
    v.uncheckImage = nil;
    v.checkItemSize = 80;
    v.checkImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@",kPlatformResourceBundle,@"GesturesDot_yellow_iPhone.png"]];
    v.warningImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@",kPlatformResourceBundle,@"GesturesDot_red_iPhone.png"]];
    v.delegate = self;
    [self.contentView addSubview:v];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 70)/2.0f, isIOS7?35:15, 70, 70)];
    [headView setBackgroundColor:[UIColor clearColor]];
    [headView.layer setMasksToBounds:YES];
    [headView.layer setBorderColor:[UIColor colorWithRed:104/255.0f green:153/255.0f blue:185/255.0f alpha:1.0f].CGColor];
    [headView.layer setBorderWidth:1.0f];
    [headView.layer setCornerRadius:(headView.frame.size.width)/2.0f];
    
    UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectInset(CGRectMake(0, 0, headView.frame.size.width, headView.frame.size.height), 5, 5)];
    [headImage setImage:[UIImage imageNamed:@"head_icon_mr.png"]];
    [headView addSubview:headImage];
    [self.contentView addSubview:headView];
    
    tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,headView.frame.origin.y + headView.frame.size.height + (([[UIScreen mainScreen] bounds].size.height > 480)?15:8),(self.view.frame.size.width - 40),20)];
    [tipLabel setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
    tipLabel.text = @"请输入手势密码";
    tipLabel.font = [UIFont systemFontOfSize:16.0f];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:tipLabel];
    
    tipAlertLabel = [[UILabel alloc] initWithFrame:CGRectInset(tipLabel.frame, 0, 0)];
    tipAlertLabel.frame = CGRectOffset(tipAlertLabel.frame, 0, tipLabel.frame.size.height);
    tipAlertLabel.text = @"连续5次输入错误后，需要重新登录";
    tipAlertLabel.font = [UIFont systemFontOfSize:13.0f];
    tipAlertLabel.textAlignment = NSTextAlignmentCenter;
    tipAlertLabel.textColor = [UIColor colorWithRed:104/255.0f green:153/255.0f blue:185/255.0f alpha:1.0f];
    tipAlertLabel.backgroundColor = [UIColor clearColor];
    [tipAlertLabel setHidden:YES];
    [self.contentView addSubview:tipAlertLabel];
    
    errorCount = 5;
    self.navigationItem.hidesBackButton = YES;
    
    forgetButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 100)/2.0, self.view.frame.size.height - (([[UIScreen mainScreen] bounds].size.height > 480)?55:30), 100, 30)];
    [forgetButton setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];

    [forgetButton setTitle:@"忘记手势密码?" forState:UIControlStateNormal];
    forgetButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    [self.contentView addSubview:forgetButton];
    [forgetButton setTitleColor:[UIColor colorWithRed:104/255.0f green:153/255.0f blue:185/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [forgetButton addTarget:self action:@selector(forgetPassword:) forControlEvents:UIControlEventTouchUpInside];
    

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)dealUnlock:(MYGestureCodeView *)codeView {
    if ([codeView.code isEqualToString:[MYPlatformAPI platformGestureCode]]) {
        [MYGestureUnlockViewController showGestureUnlockView:NO enterBlock:self.enter];
        [[NSNotificationCenter defaultCenter] postNotificationName:MYPlatformGestureCodeDidUnLockNotification object:nil];
    } else {
        if (errorCount > 1) {
            tipLabel.textColor = [UIColor colorWithRed:299/255.0f green:66/255.0f blue:62/255.0f alpha:1];
            tipLabel.text = [NSString stringWithFormat:@"密码错误,还可以再输入%d次",--errorCount];
            [tipAlertLabel setHidden:NO];
            codeView.warning = YES;
            
            double delayInSeconds = 2.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                dispatch_async(dispatch_get_main_queue(), ^{
//                    tipLabel.text = @"请输入手势密码";
//                    tipLabel.textColor = [UIColor whiteColor];
                });
            });
        } else {
            [self forgetPassword:nil];
        }
    }
}

#pragma mark - 忘记手势密码

- (void)forgetPassword:(id)sender {
    [MYGestureUnlockViewController removeGestureUnlockView];
    return;
    
//    NSString *appID = [[NSBundle mainBundle] bundleIdentifier];
//    if ([appID isEqualToString:kPlatformBundleID]) {
//        [MYGestureUnlockViewController removeGestureUnlockView];
//    } else {
//        [MYPlatformAPI gotoPlatformAsForgetGestureCode];
//    }
//    [[NSNotificationCenter defaultCenter] postNotificationName:MYPlatformForgetGestureCodeNotification object:nil];
}

#pragma mark - MYGestureCodeViewDelegate
- (void)gestureCodeViewDidFinishStroke:(MYGestureCodeView *)codeView
{
    [self dealUnlock:codeView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
