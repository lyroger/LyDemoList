//
//  AESCrypto.m
//  MobilePlatform
//
//  Created by Simon Dai on 4/23/14.
//  Copyright (c) 2014 Mysoft. All rights reserved.
//

#import "AESCrypto.h"

#define MY_AES_ENCRYPT_ALGORITHM     kCCAlgorithmAES128
#define MY_AES_ENCRYPT_BLOCK_SIZE    kCCBlockSizeAES128
#define MY_AES_ENCRYPT_KEY_SIZE      kCCKeySizeAES256

#pragma GCC diagnostic ignored "-Wselector"

#import <Availability.h>
#if !__has_feature(objc_arc)
#error This library requires automatic reference counting
#endif

@implementation AESCrypto

+ (NSData*)AESEncryptData:(NSData*)data key:(NSData*)key iv:(NSData*)iv
{
    NSData* result = nil;
    
    // setup key
    unsigned char cKey[MY_AES_ENCRYPT_KEY_SIZE];
	bzero(cKey, sizeof(cKey));
    
    NSString *str = [[NSString alloc] initWithData:key encoding:NSUTF8StringEncoding];
    
    const char *cStr = [str UTF8String];
    unsigned char keychar[16];
    
    CC_MD5(cStr, strlen(cStr), keychar ); // This is the md5 call
    for(int i=0;i<16;i++)
        cKey[i]=keychar[i];
    
    
    for(int i=15;i<31;i++)
        cKey[i]=keychar[i-15];
    
	
    // setup iv
    char cIv[MY_AES_ENCRYPT_BLOCK_SIZE];
    bzero(cIv, MY_AES_ENCRYPT_BLOCK_SIZE);
    if (iv) {
        [iv getBytes:cIv length:MY_AES_ENCRYPT_BLOCK_SIZE];
    }
    
    // setup output buffer
	size_t bufferSize = [data length] + MY_AES_ENCRYPT_BLOCK_SIZE;
	void *buffer = malloc(bufferSize);
    
    
    
    // do encrypt
	size_t encryptedSize = 0;
	CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          MY_AES_ENCRYPT_ALGORITHM,
                                          kCCOptionECBMode|kCCOptionPKCS7Padding,
                                          cKey,
                                          kCCKeySizeAES256,
                                          cIv,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
										  &encryptedSize);
    
	if (cryptStatus == kCCSuccess) {
		result = [NSData dataWithBytesNoCopy:buffer length:encryptedSize];
	} else {
        free(buffer);
    }
	
	return result;
}

+ (NSData*)AESDecryptData:(NSData*)data key:(NSData*)key iv:(NSData*)iv
{
    NSData* result = nil;
    
    // setup key
    unsigned char cKey[MY_AES_ENCRYPT_KEY_SIZE];
	bzero(cKey, sizeof(cKey));
    
    NSString *str = [[NSString alloc] initWithData:key encoding:NSUTF8StringEncoding];
    
    const char *cStr = [str UTF8String];
    unsigned char keychar[16];
    
    CC_MD5(cStr, strlen(cStr), keychar ); // This is the md5 call
    for(int i=0;i<16;i++)
        cKey[i]=keychar[i];
    
    for(int i=15;i<31;i++)
        cKey[i]=keychar[i-15];
    
    
    // setup iv
    char cIv[MY_AES_ENCRYPT_BLOCK_SIZE];
    bzero(cIv, MY_AES_ENCRYPT_BLOCK_SIZE);
    if (iv) {
        [iv getBytes:cIv length:MY_AES_ENCRYPT_BLOCK_SIZE];
    }
    
    // setup output buffer
	size_t bufferSize = [data length] + MY_AES_ENCRYPT_BLOCK_SIZE;
	void *buffer = malloc(bufferSize);
	
    // do decrypt
	size_t decryptedSize = 0;
	CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          MY_AES_ENCRYPT_ALGORITHM,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
										  cKey,
                                          MY_AES_ENCRYPT_KEY_SIZE,
                                          cIv,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &decryptedSize);
	
	if (cryptStatus == kCCSuccess) {
		result = [NSData dataWithBytesNoCopy:buffer length:decryptedSize];
	} else {
        free(buffer);
    }
    
	return result;
}

@end

@implementation NSData (MYPlatformCrypto)

+ (NSData *)dataWithBase64EncodedString:(NSString *)string
{
    if (![string length]) return nil;
    
    NSData *decoded = nil;
    
#if __MAC_OS_X_VERSION_MIN_REQUIRED < __MAC_10_9 || __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    
    if (![NSData instancesRespondToSelector:@selector(initWithBase64EncodedString:options:)])
    {
        decoded = [[self alloc] initWithBase64Encoding:[string stringByReplacingOccurrencesOfString:@"[^A-Za-z0-9+/=]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [string length])]];
    }
    else
        
#endif
        
    {
        decoded = [[self alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    }
    
    return [decoded length]? decoded: nil;
}

- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    if (![self length]) return nil;
    
    NSString *encoded = nil;
    
#if __MAC_OS_X_VERSION_MIN_REQUIRED < __MAC_10_9 || __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    
    if (![NSData instancesRespondToSelector:@selector(base64EncodedStringWithOptions:)])
    {
        encoded = [self base64Encoding];
    }
    else
        
#endif
        
    {
        switch (wrapWidth)
        {
            case 64:
            {
                return [self base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            }
            case 76:
            {
                return [self base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
            }
            default:
            {
                encoded = [self base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
            }
        }
    }
    
    if (!wrapWidth || wrapWidth >= [encoded length])
    {
        return encoded;
    }
    
    wrapWidth = (wrapWidth / 4) * 4;
    NSMutableString *result = [NSMutableString string];
    for (NSUInteger i = 0; i < [encoded length]; i+= wrapWidth)
    {
        if (i + wrapWidth >= [encoded length])
        {
            [result appendString:[encoded substringFromIndex:i]];
            break;
        }
        [result appendString:[encoded substringWithRange:NSMakeRange(i, wrapWidth)]];
        [result appendString:@"\r\n"];
    }
    
    return result;
}

- (NSString *)base64EncodedString
{
    return [self base64EncodedStringWithWrapWidth:0];
}

@end


@implementation NSString (MYPlatformCrypto)

+ (NSString *)stringWithBase64EncodedString:(NSString *)string
{
    NSData *data = [NSData dataWithBase64EncodedString:string];
    if (data)
    {
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data base64EncodedStringWithWrapWidth:wrapWidth];
}

- (NSString *)base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data base64EncodedString];
}

- (NSString *)base64DecodedString
{
    return [NSString stringWithBase64EncodedString:self];
}

- (NSData *)base64DecodedData
{
    return [NSData dataWithBase64EncodedString:self];
}



@end


