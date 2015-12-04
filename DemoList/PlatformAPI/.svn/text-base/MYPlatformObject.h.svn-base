//
//  MYLoginUser.h
//  SDKSample
//
//  Created by Simon Dai on 4/14/14.
//
//

#import <Foundation/Foundation.h>

@interface MYPlatformLoginObject : NSObject
//登录名
@property (nonatomic,copy) NSString *userCode;
//用户GUID
@property (nonatomic,copy) NSString *userGUID;
//用户名
@property (nonatomic,copy) NSString *userName;
//密码
@property (nonatomic,copy) NSString *password;
//服务器地址
@property (nonatomic,copy) NSString *serverAddr;
//Token
@property (nonatomic,copy) NSString *token;
//云服务地址
@property (nonatomic,copy) NSString *cloudAddr;
//企业代码
@property (nonatomic,copy) NSString *entCode;
//企业名称
@property (nonatomic,copy) NSString *entName;
//设备Mac地址，唯一标识
@property (nonatomic,copy) NSString *deviceMac;
//License
@property (nonatomic,copy) NSString *license;

- (void)setUserCode:(NSString *)code password:(NSString *)pass serverAddr:(NSString *)server;

@end

//第三方请求平台的事件类型
typedef enum {
    MYPlatformActionTypeNone = 0,
    MYPlatformActionTypeEnter,
    MYPlatformActionTypeLogin,
    MYPlatformActionTypeForgetGestureCode,
    MYPlatformActionTypeTabbarIndex
} MYPlatformActionType;

#define kPlatformActionType                 @"actionType"
#define kPlatformActionInfo                 @"actionInfo"
#define kPlatformActionTypeStrs             @[@"",@"Enter",@"Login",@"ForgetGestureCode",@"TabbarIndex"]
#define kPlatformActionSender               @"urlScheme"

@interface MYPlatformAction : NSObject

@property (nonatomic,assign) MYPlatformActionType actionType;
@property (nonatomic,copy) NSString *info;

- (id)initWithActionType:(MYPlatformActionType)actionType;

- (NSString *)URLParameterString;
- (void)reset;

@end
