//
//  MYPlatformAPI.m
//  SDKSample
//
//  Created by Simon Dai on 4/14/14.
//
//

#import "MYPlatformAPI.h"
#import "MYPlatformAPIDefines.h"
#import "MYPlatformObject.h"
#import "AESCrypto.h"
#import "MYGestureUnlockViewController.h"

#import "MYPlatformPrivateAPI.h"

static NSString *ActionInfo;

@interface MYPlatformAPI () <UIAlertViewDelegate> {
    
}

@end

static BOOL isOpenFromPlatform_;

@implementation MYPlatformAPI

+ (NSString *)actionInfo {
    return ActionInfo;
}

+ (NSString *)platformBundleID {
    return kPlatformBundleID;
}

+ (BOOL)isPlatformInstalled {
    return [[UIApplication sharedApplication] canOpenURL:kPlatformURL];
}


static BOOL AlertShowing;
+ (BOOL)installPlatformOnCloudIfNeed {
    if ([self isPlatformInstalled]) {
        return NO;
    }
    if (AlertShowing == NO) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
//                                                            message:@"您需要安装“明源微助手”才能正常使用本应用。"
//                                                           delegate:self
//                                                  cancelButtonTitle:@"取消"
//                                                  otherButtonTitles:@"立即下载", nil];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您需要安装“微助手”才能正常使用本应用。"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"立即下载", nil];
        [alertView show];
        AlertShowing = YES;
    }
    
    return YES;
}


+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        exit(0);
    } else {
        NSString *urlStr = [NSString stringWithFormat:@"http://%@/%@",[[self platformLoginObject] cloudAddr],@"Mobile/Enterprise.aspx"];
        NSURL *url = [NSURL URLWithString:urlStr];
        [[UIApplication sharedApplication] openURL:url];
    }
    AlertShowing = NO;
}

+ (MYPlatformLoginObject *)platformLoginObject {
    //如果本应用存在demo用户，则优先使用
    NSString *appLoginPB = [NSString stringWithFormat:@"%@.login",[[NSBundle mainBundle] bundleIdentifier]];
    UIPasteboard *pasteboard = [UIPasteboard pasteboardWithName:appLoginPB create:NO];
    MYPlatformLoginObject *loginObject = [NSKeyedUnarchiver unarchiveObjectWithData:[pasteboard dataForPasteboardType:@"loginObject"]];
    //不存在demo用户，则使用平台的登录用户
    if (!pasteboard || !loginObject) {
        pasteboard = [UIPasteboard pasteboardWithName:kPlatformPasteboard_Login create:NO];
        loginObject = [NSKeyedUnarchiver unarchiveObjectWithData:[pasteboard dataForPasteboardType:@"loginObject"]];
    }
    
    if (loginObject) {
        NSData *data = [loginObject.password base64DecodedData];
        NSData *keyData = [kPlatformMysoftDESKEY dataUsingEncoding:NSUTF8StringEncoding];
        
        NSString *password = [[NSString alloc] initWithData:[AESCrypto AESDecryptData:data key:keyData iv:nil]
                                                   encoding:NSUTF8StringEncoding];
        
        loginObject.password = password;
    }
    
    return loginObject;
}

+ (BOOL)syncGestureLockView {
    NSString *token = [MYPlatformAPI platformLoginObject].token;
    //对比时间，判断显示手势密码
    if ([self isPlatformInstalled] && [self platformGestureCode].length && ![self appIsOpenFromPlatform] && [token length]) {
        NSDate *currentDate = [NSDate date];
        NSDate *date = [self gestureCodeStartTime];
        NSTimeInterval time = [currentDate timeIntervalSinceDate:date];
        CGFloat min = [MYPlatformAPI gestureCodeActivtyTime];
        if (date == nil || time > min*60)
        {
            [MYGestureUnlockViewController showGestureUnlockViewWithEnterBlock:^{
                
            }];
            return YES;
        }
        return [MYGestureUnlockViewController isGestureLockShowing];
    }
    
    [MYGestureUnlockViewController removeGestureUnlockView];
    return NO;
}

+ (void)gotoPlatform {
    MYPlatformAction *action = [[MYPlatformAction alloc] initWithActionType:MYPlatformActionTypeEnter];
    [self gotoPlatformWithAction:action];
}

+ (void)gotoPlatformForLogin {
    dispatch_async(dispatch_get_main_queue(), ^{
        MYPlatformAction *action = [[MYPlatformAction alloc] initWithActionType:MYPlatformActionTypeLogin];
        [self gotoPlatformWithAction:action];
    });
}

+ (void)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication {
    //只处理来自平台的跳转
    if ([sourceApplication isEqualToString:kPlatformBundleID]) {
        [MYGestureUnlockViewController removeGestureUnlockView];
        
        isOpenFromPlatform_ = YES;
        
        NSArray *strings = [url.absoluteString componentsSeparatedByString:@"://"];
        if ([strings count] > 1) {
            NSString *info = [strings lastObject];
            info = [info stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            ActionInfo = info;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:MYPlatformConnectWithAppChangedNotification object:nil];
    }
}

+ (NSString *)platformVersion {
    if ([self isPlatformInstalled]) {
        UIPasteboard *pasteboard = [UIPasteboard pasteboardWithName:kPlatformPasteboard_PlatformVersion create:NO];
        if (pasteboard) {
            [pasteboard valueForPasteboardType:@"String"];
        }
    }
    return nil;
}

+ (void)handleAppEnterBackground {
    isOpenFromPlatform_ = NO;
    ActionInfo = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:MYPlatformConnectWithAppChangedNotification object:nil];
    
    [self storeGestureCodeStartTime];
}

+ (BOOL)appIsOpenFromPlatform {
    return isOpenFromPlatform_;
}

+ (BOOL)appIsDemoVersion {
    NSString *appLoginPB = [NSString stringWithFormat:@"%@.login",[[NSBundle mainBundle] bundleIdentifier]];
    UIPasteboard *pasteboard = [UIPasteboard pasteboardWithName:appLoginPB create:NO];
    if (pasteboard) {
        MYPlatformLoginObject *loginObject = [NSKeyedUnarchiver unarchiveObjectWithData:[pasteboard dataForPasteboardType:@"loginObject"]];
        if (loginObject) {
            return YES;
        }
    }
    return NO;
}

+ (void)storeDemoAppLoginObject:(MYPlatformLoginObject *)loginObj {
    NSString *pdName = [NSString stringWithFormat:@"%@.login",[[NSBundle mainBundle] bundleIdentifier]];
    UIPasteboard *pasteboard = [UIPasteboard pasteboardWithName:pdName create:NO];
    if (pasteboard) {
        NSData *pData = [AESCrypto AESEncryptData:[loginObj.password dataUsingEncoding:NSUTF8StringEncoding]
                                              key:[kPlatformMysoftDESKEY dataUsingEncoding:NSUTF8StringEncoding]
                                               iv:nil];
        
        loginObj.password = [pData base64EncodedString];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:loginObj];
        [pasteboard setData:data forPasteboardType:@"loginObject"];
        
    }
}

+ (NSURL *)platformAuthRequestURLWithToken:(NSString *)token {
    MYPlatformLoginObject *loginObject = [self platformLoginObject];
    NSString *urlStr = [NSString stringWithFormat:@"%@/apps/Mysoft.Apps.Portal.Services.Public/SaveDeviceTokenInfo.aspx?AppName=MobilePublic&token=%@&datatype=json",loginObject.serverAddr,[token length]?token:loginObject.token];
    return [NSURL URLWithString:urlStr];
}

+ (NSDictionary *)erpRequestHeaderWithAppName:(NSString *)appName deviceToken:(NSString *)deviceToken {
    MYPlatformLoginObject *loginObject = [self platformLoginObject];
    NSString *authHeader = [self composeAuthHeaderWithUserCode:loginObject.userCode
                                                      password:loginObject.password
                                                       appName:appName
                                                     deviceMac:loginObject.deviceMac
                                                   deviceToken:deviceToken];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:2];
    [dict setObject:authHeader forKey:@"AuthenticationHeader"];
    if (loginObject.license) {
        [dict setObject:loginObject.license forKey:@"License"];
    }
    
    return dict;
}

+ (BOOL)validateAuthWithResponse:(NSString *)response errorMessage:(NSString **)message {
    MYPlatformLoginObject *loginObj = [MYPlatformAPI platformLoginObject];
    
    if ([response rangeOfString:@"身份校验失败"].length || [response rangeOfString:@"登录超时"].length || [loginObj.token length] == 0) {
        if ([loginObj.token length] == 0) {
            *message = @"未登录，即将进入微助手登录";
        } else {
            *message = @"登录失效，即将进入微助手登录";
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:MYPlatformAuthFailNotification object:nil userInfo:nil];
        return NO;
    } else {
        *message = nil;
    }
    return YES;
}

+ (NSURL *)platformAuthRequestURL {
    MYPlatformLoginObject *loginObject = [self platformLoginObject];
    NSString *urlStr = [NSString stringWithFormat:@"%@/apps/Mysoft.Apps.Portal.Services.Public/SaveDeviceTokenInfo.aspx?token=%@&datatype=json",loginObject.serverAddr,loginObject.token];
    return [NSURL URLWithString:urlStr];
}

+ (UIBarButtonItem *)homeBarButtonItem {
    NSString *imageName = [NSString stringWithFormat:@"%@/%@",kPlatformResourceBundle,@"btn_xiaowei.png"];
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imageName]
                                            style:UIBarButtonItemStyleBordered
                                           target:self
                                           action:@selector(gotoPlatform)];
}

@end
