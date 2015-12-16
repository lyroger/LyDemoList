//
//  CommonFun.h
//  DemoList
//
//  Created by luoyan on 15/12/16.
//  Copyright © 2015年 luoyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonFun : NSObject
+ (UIImage *)accelerateBlurWithImage:(UIImage *)image;
//加模糊效果，image是图片，blur是模糊度
+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

//截屏
+ (UIImage *)snapshot:(UIView *)view rect:(CGRect)rect;

@end
