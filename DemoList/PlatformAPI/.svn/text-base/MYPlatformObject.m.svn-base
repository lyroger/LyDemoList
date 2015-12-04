//
//  MYLoginUser.m
//  SDKSample
//
//  Created by Simon Dai on 4/14/14.
//
//

#import "MYPlatformObject.h"
#import "AESCrypto.h"
#import "MYPlatformAPIDefines.h"

@implementation MYPlatformLoginObject

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        _userCode = [decoder decodeObjectForKey:@"userCode"];
        _password = [decoder decodeObjectForKey:@"password"];
        _serverAddr = [decoder decodeObjectForKey:@"serverAddr"];
        _token = [decoder decodeObjectForKey:@"token"];
        _cloudAddr = [decoder decodeObjectForKey:@"cloudAddr"];
        _entCode = [decoder decodeObjectForKey:@"entCode"];
        _userGUID = [decoder decodeObjectForKey:@"userGUID"];
        _entName = [decoder decodeObjectForKey:@"entName"];
        _userName = [decoder decodeObjectForKey:@"userName"];
        _deviceMac = [decoder decodeObjectForKey:@"deviceMac"];
        _license = [decoder decodeObjectForKey:@"license"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_userCode forKey:@"userCode"];
    [encoder encodeObject:_password forKey:@"password"];
    [encoder encodeObject:_serverAddr forKey:@"serverAddr"];
    [encoder encodeObject:_token forKey:@"token"];
    [encoder encodeObject:_cloudAddr forKey:@"cloudAddr"];
    [encoder encodeObject:_entCode forKey:@"entCode"];
    [encoder encodeObject:_userGUID forKey:@"userGUID"];
    [encoder encodeObject:_entName forKey:@"entName"];
    [encoder encodeObject:_userName forKey:@"userName"];
    [encoder encodeObject:_deviceMac forKey:@"deviceMac"];
    [encoder encodeObject:_license forKey:@"license"];
}


- (void)setUserCode:(NSString *)code password:(NSString *)pass serverAddr:(NSString *)server {
    _password = pass;
    _userCode = code;
    _serverAddr = server;
}

@end

@implementation MYPlatformAction

- (id)initWithActionType:(MYPlatformActionType)actionType {
    self = [self init];
    if (self) {
        self.actionType = actionType;
    }
    return self;
}

- (void)reset {
    self.actionType = MYPlatformActionTypeNone;
    self.info = nil;
}

- (NSString *)URLParameterString {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:3];
    
    NSDictionary *infoList = [[NSBundle mainBundle] infoDictionary];
    NSArray *urlTypes = [infoList valueForKey:@"CFBundleURLTypes"];
    if ([urlTypes count]) {
        NSDictionary *urlScheme=[urlTypes objectAtIndex:0];
        NSArray *scheme = [urlScheme objectForKey:@"CFBundleURLSchemes"];
        if ([scheme count]) {
            [dict setObject:[scheme objectAtIndex:0] forKey:kPlatformActionSender];
        }
    }
    
    NSString *actionStr = [kPlatformActionTypeStrs objectAtIndex:self.actionType];
    [dict setObject:actionStr forKey:kPlatformActionType];
    if (self.info) {
        [dict setObject:self.info forKey:kPlatformActionInfo];
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *param = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return [param stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end