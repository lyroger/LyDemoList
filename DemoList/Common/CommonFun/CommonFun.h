//
//  CommonFun.h
//  DemoList
//
//  Created by luoyan on 16/1/20.
//  Copyright © 2016年 luoyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonFun : NSObject
+ (UIImage *)accelerateBlurWithImage:(UIImage *)image;

//截屏
+ (UIImage *)snapshot:(UIView *)view rect:(CGRect)rect;

@end
