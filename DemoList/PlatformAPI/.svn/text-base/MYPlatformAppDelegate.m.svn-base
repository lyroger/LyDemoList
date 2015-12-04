//
//  MYPlatformAppDelegate.m
//  DSSPlatform
//
//  Created by Simon Dai on 6/17/14.
//  Copyright (c) 2014 Mysoft. All rights reserved.
//

#import "MYPlatformAppDelegate.h"
#import "AESCrypto.h"

@interface MYPlatformAppDelegate () {
    
}

@property (nonatomic,strong) MYPlatformLoginObject *loginObj;

@end

@implementation MYPlatformAppDelegate

@synthesize loginObj = loginObj_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSAssert(self.delegate,@"请在你的AppDelegate启动的第一代码设置delegate，如：self.delegate = self");
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    if ([self.delegate respondsToSelector:@selector(showUserGuideIfNeed)] && [self.delegate showUserGuideIfNeed]) {
        
    } else {
        [self enterProcess];
    }
    
    [self.window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleGestureCodeDidUnLockNotification:)
                                                 name:MYPlatformGestureCodeDidUnLockNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleAppDidEnterBackgroundNotification:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleAppWillEnterForegroundNotification:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(gotoPlatformForLogin)
                                                 name:MYPlatformAuthFailNotification
                                               object:nil];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [MYPlatformAPI handleOpenURL:url sourceApplication:sourceApplication];
    [self enterProcess];
    
    BOOL isShowingUserGuide = NO;
    if ([self.delegate respondsToSelector:@selector(showUserGuideIfNeed)] && [self.delegate showUserGuideIfNeed]) {
        isShowingUserGuide = [self.delegate showUserGuideIfNeed];
    }
    if (!isShowingUserGuide) {
        if ([self.delegate respondsToSelector:@selector(handlePlatformAction:)]) {
            [self.delegate handlePlatformAction:[MYPlatformAPI actionInfo]];
        }
    }
    return YES;
}

- (void)enterProcess {
    self.window.userInteractionEnabled = YES;
    //小微未安装，弹出提示
    if ([MYPlatformAPI installPlatformOnCloudIfNeed]) {
        [self resetRootViewController];
        return;
    }
    MYPlatformLoginObject *loginObject = [MYPlatformAPI platformLoginObject];
    NSString *sessionUsercode = loginObj_.userCode;
    //对比小微和当前的登录数据，如果用户不一致，则退至首页
    if (sessionUsercode && ![sessionUsercode isEqualToString:loginObject.userCode]) {
        [self resetRootViewController];
        self.loginObj = loginObject;
        [self setupRootViewController];
    } else { //小微和当前用户一致
        self.loginObj = loginObject;
        
        if ([self.delegate respondsToSelector:@selector(showUserGuideIfNeed)] && [self.delegate showUserGuideIfNeed]) {
            
        } else {
            //不需显示引导画面，如果rootViewController为nil，则赋值。rootViewController为nil的情况可能存在，比如从引导界面进入时
            if (self.window.rootViewController == nil) {
                [self setupRootViewController];
            }
            //如果程序是从小微跳转过来的，且解锁密码不需显示，则处理跳转事件
            if ([MYPlatformAPI appIsOpenFromPlatform] && ![MYPlatformAPI syncGestureLockView]) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(handlePlatformAction:)]) {
                    [self.delegate handlePlatformAction:[MYPlatformAPI actionInfo]];
                }
            }
        }
    }
}

- (void)setLoginObj:(MYPlatformLoginObject *)loginObj {
    loginObj_ = loginObj;
    [self.delegate syncSessionWithPlatformLoginObject:loginObj];
}

- (void)resetRootViewController {
    self.window.rootViewController = nil;
}

- (void)setupRootViewController {
    self.window.rootViewController = [self.delegate rootViewController];
    if ([self.delegate respondsToSelector:@selector(sendDeviceTokenToPlatformServer:)]) {
        [self.delegate sendDeviceTokenToPlatformServer:[MYPlatformAPI platformAuthRequestURL]];
    }
}


- (void)gotoPlatformForLogin {
    NSLog(@"Auth Fail ---- user:%@ token:%@",loginObj_.userCode,loginObj_.token);
    
    NSString *message;
    if ([loginObj_.token length] == 0) {
        message = @"未登录，即将进入微助手登录";
    } else {
        message = @"登录失效，即将进入微助手登录";
    }
    if ([self.delegate respondsToSelector:@selector(toastAuthFailMessage:)]) {
        [self.delegate toastAuthFailMessage:message];
        self.window.userInteractionEnabled = NO;
        [MYPlatformAPI performSelector:@selector(gotoPlatformForLogin) withObject:nil afterDelay:2.0f];
    } else {
        [MYPlatformAPI performSelector:@selector(gotoPlatformForLogin) withObject:nil afterDelay:0];
    }
}

- (MYPlatformLoginObject *)loginSession {
    return loginObj_;
}

#pragma mark - Handle Notification
- (void)handleGestureCodeDidUnLockNotification:(NSNotification *)userInfo {
    if ([MYPlatformAPI appIsOpenFromPlatform]) {
        if ([self.delegate respondsToSelector:@selector(handlePlatformAction:)]) {
            [self.delegate handlePlatformAction:[MYPlatformAPI actionInfo]];
        }
    }    
}

- (void)handleAppDidEnterBackgroundNotification:(NSNotification *)userInfo {
    [MYPlatformAPI handleAppEnterBackground];
    [MYPlatformAPI syncGestureLockView];
    if ([self.delegate respondsToSelector:@selector(sendDeviceTokenToPlatformServer:)]) {
        [self.delegate sendDeviceTokenToPlatformServer:[MYPlatformAPI platformAuthRequestURL]];
    }
}

- (void)handleAppWillEnterForegroundNotification:(NSNotification *)userInfo {
    //延迟执行，使得从小微进入时，先执行 - (BOOL)application: openURL: sourceApplication: annotation:方法
    [self performSelector:@selector(tryEnterProcess) withObject:nil afterDelay:0.1f];
}

- (void)tryEnterProcess {
    if (![MYPlatformAPI appIsOpenFromPlatform]) {
        [self enterProcess];
    }
}

@end
