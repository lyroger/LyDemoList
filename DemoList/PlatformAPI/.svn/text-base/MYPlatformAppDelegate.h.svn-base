//
//  MYPlatformAppDelegate.h
//  DSSPlatform
//
//  Created by Simon Dai on 6/17/14.
//  Copyright (c) 2014 Mysoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MYPlatformAPI.h"

@protocol MYPlatformAppDelegate <NSObject>

@optional
/**
 *  进入应用引导画面，引导画面完成后需手动调用enterProcess
 *
 *  @return 如果需要进引导画面或引导画面已经显示，返回YES
 */
- (BOOL)showUserGuideIfNeed;

/**
 *  处理小微传过来的跳转事件
 *
 *  @param actionInfo actionInfo由后台定义，一般是一个json
 */
- (void)handlePlatformAction:(NSString *)actionInfo;

/**
 *  当移动X希望接受小微后台的通知时，需把DeviceToken传给小微后台
 *
 *  @param url 请求的URL，另外注意请求需要带上Header
 */
- (void)sendDeviceTokenToPlatformServer:(NSURL *)url;

/**
 *  将小微的登录数据同步到Session，在登录数据可能被改变时执行，分别是从程序运行时、从后台进入前台时、从小微进入程序时
 *
 *  @param loginObject 登录数据
 */
- (void)syncSessionWithPlatformLoginObject:(MYPlatformLoginObject *)loginObject;

/**
 *  当身份校验失败时，弹出相关提示。若该接口被实现，程序将在2.0秒后（显示完提示信息）进入小微重新登录，否则程序直接跳转至小微
 *
 *  @param message 提示信息
 */
- (void)toastAuthFailMessage:(NSString *)message;

@required
/**
 *  程序运行后需要进入的主界面，一般是个tabBarController或navigationController
 *
 *  @return 返回主界面
 */
- (UIViewController *)rootViewController;
@end

@interface MYPlatformAppDelegate : UIResponder <UIApplicationDelegate, UIGestureRecognizerDelegate> {
    
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,assign) id<MYPlatformAppDelegate> delegate;
/**
 *  登录session，始终与小微的session同步
 *
 *  @return 返回登录session
 */
- (MYPlatformLoginObject *)loginSession;

/**
 *  进入主界面，引导画面完成后需手动调用enterProcess，其他情况一般不需要手动调用
 */
- (void)enterProcess;

@end
