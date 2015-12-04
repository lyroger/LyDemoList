//
//  AESCrypto.h
//  MobilePlatform
//
//  Created by Simon Dai on 4/23/14.
//  Copyright (c) 2014 Mysoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

@interface AESCrypto : NSObject
+ (NSData*)AESEncryptData:(NSData*)data key:(NSData*)key iv:(NSData*)iv;
+ (NSData*)AESDecryptData:(NSData*)data key:(NSData*)key iv:(NSData*)iv;
@end

@interface NSData (MYPlatformCrypto)
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;
- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)base64EncodedString;
@end


@interface NSString (MYPlatformCrypto)
+ (NSString *)stringWithBase64EncodedString:(NSString *)string;
- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)base64EncodedString;
- (NSString *)base64DecodedString;
- (NSData *)base64DecodedData;

@end

