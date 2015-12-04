//
//  MYPlatformPrivateAPI.m
//  MobilePlatform
//
//  Created by Simon Dai on 5/21/14.
//  Copyright (c) 2014 Mysoft. All rights reserved.
//

#import "MYPlatformPrivateAPI.h"
#import "AESCrypto.h"
#import "MYGestureUnlockViewController.h"

@implementation MYPlatformAPI (Private)

+ (void)gotoPlatformWithAction:(MYPlatformAction *)action {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",kPlatformURL,[action URLParameterString]];
    NSURL *url = [NSURL URLWithString:urlStr];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] openURL:url];
    });
}

+ (void)gotoPlatformAsForgetGestureCode {
    MYPlatformAction *action = [[MYPlatformAction alloc] initWithActionType:MYPlatformActionTypeForgetGestureCode];
    [self gotoPlatformWithAction:action];
}

+ (NSString *)platformGestureCode {
    if ([self isPlatformGestureCodeEnable] == NO) {
        return nil;
    }
    NSString *userCode = [MYPlatformAPI platformLoginObject].userCode;
    
    UIPasteboard *pasteboard = [UIPasteboard pasteboardWithName:kPlatformPasteboard_GestureCode create:NO];
    NSData *dictData = [pasteboard dataForPasteboardType:@"Dict"];
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:dictData];
    
    NSData *codeData = [[dict objectForKey:userCode] base64DecodedData];
    NSData *keyData = [kPlatformMysoftDESKEY dataUsingEncoding:NSUTF8StringEncoding];
    NSString *code = [[NSString alloc] initWithData:[AESCrypto AESDecryptData:codeData key:keyData iv:nil]
                                           encoding:NSUTF8StringEncoding];
    //用usercode对应手势密码，而不是用usercode+服务器地址对应手势密码，存在缺陷。影响：对于子应用，多个服务器上一样的usercode可能不是同一个用户，而一个usercode对应一个手势密码。
    return code;
}

+ (BOOL)isPlatformGestureCodeEnable {
    NSString *userCode = [MYPlatformAPI platformLoginObject].userCode;
    if ([self isPlatformInstalled]) {
        UIPasteboard *pasteboard = [UIPasteboard pasteboardWithName:kPlatformPasteboard_GestureLockUsers create:NO];
        NSData *data = [pasteboard dataForPasteboardType:@"Set"];
        NSSet *set = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        //用usercode对应手势密码，而不是用usercode+服务器地址对应手势密码，存在缺陷。影响：对于子应用，多个服务器上一样的usercode可能不是同一个用户，而一个usercode对应一个手势密码。
        if ([set containsObject:userCode]) {
            return YES;
        }
    }
    return NO;
}

+ (void)storeGestureCodeStartTime
{
    if ([MYGestureUnlockViewController isGestureLockShowing]) {
        return;
    }
    UIPasteboard *pasteboard = [UIPasteboard pasteboardWithName:kPlatformPasteboard_EnterBackgroundTime create:YES];
    [pasteboard setPersistent:YES];
    
    NSData *data = [pasteboard dataForPasteboardType:@"Dictionary"];
    NSDictionary *dataDic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dataDic];
    NSDate *currentDate = [NSDate date];
    [dict setObject:currentDate forKey:kGestureLockTime];
    
    data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    
    [pasteboard setValue:data forPasteboardType:@"Dictionary"];
}

+ (NSDate *)gestureCodeStartTime
{
    UIPasteboard *pasteboard = [UIPasteboard pasteboardWithName:kPlatformPasteboard_EnterBackgroundTime create:NO];
    NSData *data = [pasteboard dataForPasteboardType:@"Dictionary"];
    NSMutableDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    NSDate *date = [dict objectForKey:kGestureLockTime];
    
    return date;
}

+ (CGFloat)gestureCodeActivtyTime {
    UIPasteboard *pasteboard = [UIPasteboard pasteboardWithName:kPlatformPasteboard_GestureLockTime create:YES];
    [pasteboard setPersistent:NO];
    NSData *data = [pasteboard dataForPasteboardType:@"Number"];
    NSNumber *num = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return [num floatValue];
}


+ (NSString *)composeAuthHeaderWithUserCode:(NSString *)username
                                   password:(NSString *)password
                                    appName:(NSString *)appname
                                  deviceMac:(NSString *)deviceMac
                                deviceToken:(NSString *)deviceToken {
    
    //NSString *deviceMac = [[[UIDevice currentDevice] macAddress] MD5];
    NSString *deviceType = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? @"phone":@"pad";
    NSString *deviceName = [[UIDevice currentDevice] name];
    NSString *OSVersion = [NSString stringWithFormat:@"iOS%@",[[UIDevice currentDevice] systemVersion]];
    NSString *deviceModel = [[UIDevice currentDevice] model];
    
    // 用户名 密码 应用程序名 设备标识 设备类型 设备名称 OS版本 设备型号 设备Devicetoken”,字段之间分隔符为 \3
    // Admin\3D41D8CD98F00B204E9800998ECF8427E\3MobileWorkflow\324F41971-3CDF-4E82-8860-90195AB75091\3iPad\3KylinZhu\3iOS5.0.1\3iPhone 4S\3205714a1ed2b8f90e5d7056aa37c94a47bd9ba5ace4066cb86940f506d72f4ba
    NSString* auth = [NSString stringWithFormat:@"%@\3%@\3%@\3%@\3%@\3%@\3%@\3%@\3%@",
                      username ? username : @"",
                      password ? password : @"",
                      appname ? appname : @"",
                      deviceMac ? deviceMac:@"",
                      deviceType,
                      deviceName,
                      OSVersion,
                      deviceModel,
                      deviceToken ? deviceToken : @""];
    NSData *encryptData = [AESCrypto AESEncryptData:[auth dataUsingEncoding:NSUTF8StringEncoding]
                                                key:[kPlatformMysoftDESKEY dataUsingEncoding:NSUTF8StringEncoding]
                                                 iv:nil];
    auth = [encryptData base64Encoding];
    return auth;
}


@end
