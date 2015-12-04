//
//  MYPlatformAPI.h
//  SDKSample
//
//  Created by Simon Dai on 4/14/14.
//
//

#import <Foundation/Foundation.h>
#import "MYPlatformObject.h"

//平台进入应用，或应用退到后台后，API会发出该通知，APP可通过监听该通知，配合appIsOpenFromPlatform判断是否显示返回平台的按钮
#define MYPlatformConnectWithAppChangedNotification           @"MYPlatformConnectWithAppChangedNotification"
//点击解锁界面的忘记密码，会发出该通知，APP应该在此时重置Session和界面
#define MYPlatformForgetGestureCodeNotification               @"MYPlatformForgetGestureCodeNotification"
//解锁成功通知
#define MYPlatformGestureCodeDidUnLockNotification            @"MYPlatformGestureCodeDidUnLockNotification"
//HTTP请求身份认证失败
#define MYPlatformAuthFailNotification                        @"MYPlatformAuthFailNotification"


@interface MYPlatformAPI : NSObject

/**
 *  获取平台的bundleID
 *
 *  @return 返回bundleID
 */
+ (NSString *)platformBundleID;

/**
 *  平台是否安装
 *
 *  @return 已安装返回YES
 */
+ (BOOL)isPlatformInstalled;

/**
 *  如果未安装平台，则弹出对话框，提示安装
 *
 *  @return 如果需要安装，返回YES；已安装则返回NO
 */
+ (BOOL)installPlatformOnCloudIfNeed;

/**
 *  获取平台版本
 *
 *  @return 返回平台版本
 */
+ (NSString *)platformVersion;

/**
 *  获取本应用的登录数据，一般情况下登录数据与平台相同，如果是体验版app则返回体验账号
 *
 *  @return 返回一个应用的登录数据
 */
+ (MYPlatformLoginObject *)platformLoginObject;


/**
 *  同步平台的解锁界面，该方法需要在applicationDidEnterBackground,applicationWillEnterForeground的时候调用
 *
 *  @return 解锁界面是否显示
 */
+ (BOOL)syncGestureLockView;

/**
 *  进入平台
 */
+ (void)gotoPlatform;

/**
 *  Token过期，进入平台登录
 */
+ (void)gotoPlatformForLogin;

/**
 *  必要：从平台进入本应用，在application:openURL:sourceApplication:annotation:中处理
 *
 *  @param url               OpenURL
 *  @param sourceApplication sourceApplication
 */
+ (void)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication;


/**
 *  必要：进入后台时，需做相关处理（重置action，重置连接状态）
 */
+ (void)handleAppEnterBackground;


/**`
 *  本次启动是否从平台跳转
 *
 *  @return 从平台跳转则返回YES
 */
+ (BOOL)appIsOpenFromPlatform;

/**
 *  平台传过来的事件信息
 */
+ (NSString *)actionInfo;

/**
 *  是否是演示版本
 */
+ (BOOL)appIsDemoVersion;

/**
 *  演示版本app存储登录数据
 *  演示版本app需要自己登录，在登录成功后调用该方法存储登录对象，之后调用platformLoginObject方法即是返回该对象
 *  该方法可以让程序对于正式和演示用户有相同的获取登录数据的逻辑，对于正式版app来说该方法是安全的
 */
+ (void)storeDemoAppLoginObject:(MYPlatformLoginObject *)loginObj;


/**
 *  发送请求给平台服务端，使平台服务端可以向本应用发推送。注：请求需要带上AuthenticationHeader
 *
 *  @return 返回请求URL
 */
+ (NSURL *)platformAuthRequestURL;

/**
 *  创建ERP请求头
 *
 *  @param appName     当前应用名称
 *  @param deviceToken 推送Token
 *
 *  @return 所有请求头信息，格式如{"AuthenticationHeader":"D2DE","License":"78ED"}
 */
+ (NSDictionary *)erpRequestHeaderWithAppName:(NSString *)appName deviceToken:(NSString *)deviceToken;

/**
 *  返回小微的按钮
 *
 *  @return 返回小微的按钮
 */
+ (UIBarButtonItem *)homeBarButtonItem;

/**
 *  通过http请求返回的字符串，验证header和token是否有效
 *
 *  @param response http请求返回的字符串
 *  @param message  验证结果，nil为成功
 *
 *  @return 验证通过返回YES
 */
+ (BOOL)validateAuthWithResponse:(NSString *)response errorMessage:(NSString **)message;

@end
