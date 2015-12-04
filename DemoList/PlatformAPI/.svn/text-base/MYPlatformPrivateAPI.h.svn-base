//
//  MYPlatformPrivateAPI.h
//  MobilePlatform
//
//  Created by Simon Dai on 5/21/14.
//  Copyright (c) 2014 Mysoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MYPlatformAPI.h"
#import "MYPlatformAPIDefines.h"

#define kPlatformURL    [NSURL URLWithString:[NSString stringWithFormat:@"%@://",kPlatformURLSchemes]]

@interface MYPlatformAPI (Private)

/**
 *  进入平台，请求平台处理事件（目前主动请求平台的事件不多，所以暂不开放此接口，而是提供事件的方法）
 *
 *  @param action 平台需要处理的事件
 */
+ (void)gotoPlatformWithAction:(MYPlatformAction *)action;

/**
 *  忘记手势密码，进入平台重新登录，解锁界面会自动调用该方法。所以一般不主动调用
 */
+ (void)gotoPlatformAsForgetGestureCode;


/**
 *  获取用户的手势密码，该用户是platformLoginObject
 *
 *
 *  @return 返回用户的手势密码，nil表示空或者未设置手势密码
 */
+ (NSString *)platformGestureCode;

//存储手势密码计时时间
+ (void)storeGestureCodeStartTime;

//获取手势密码计时时间
+ (NSDate *)gestureCodeStartTime;

+ (CGFloat)gestureCodeActivtyTime;

+ (NSString *)composeAuthHeaderWithUserCode:(NSString *)username
                                   password:(NSString *)password
                                    appName:(NSString *)appname
                                  deviceMac:(NSString *)deviceMac
                                deviceToken:(NSString *)deviceToken;

@end
