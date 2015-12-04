//
//  MYGestureCodeView.h
//  DSSPlatform
//
//  Created by James on 13-4-3.
//  Copyright (c) 2013年 mysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    MYGestureCodeViewCodeNotSetup,
    MYGestureCodeViewCodeNotMatch,
    MYGestureCodeViewCodeMatch
} MYGestureCodeViewCodeMatchStatus;

@protocol MYGestureCodeViewDelegate;

@interface MYGestureCodeView : UIView {
    CGFloat checkItemSize_;
    UIImage *itemBackgroundImage_;
    UIImage *checkImage_;
    UIImage *uncheckImage_;
    UIImage *warningImage_;
    UIColor *strokeColor_;
    UIColor *warningColor_;
    CGFloat strokeLineWidth_;
    NSString *code_;
    
    __weak id <MYGestureCodeViewDelegate> delegate_;
    
    MYGestureCodeViewCodeMatchStatus codeMatch_;
    NSString *passCode_;
    BOOL warning_;;
}

@property (nonatomic, assign) CGFloat checkItemSize;
@property (nonatomic, strong) UIImage *itemBackgroundImage;
@property (nonatomic, strong) UIImage *checkImage;
@property (nonatomic, strong) UIImage *uncheckImage;
@property (nonatomic, strong) UIImage *warningImage;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, strong) UIColor *warningColor;
@property (nonatomic, assign) CGFloat strokeLineWidth;
@property (nonatomic, strong, readonly) NSString *code;
@property (nonatomic, weak) id <MYGestureCodeViewDelegate> delegate;
@property (nonatomic, assign, readonly) MYGestureCodeViewCodeMatchStatus codeMatch;
@property (nonatomic, strong) NSString *passCode;
@property (nonatomic, assign, getter = isWarning) BOOL warning;

//重置
- (void)reset;

@end


@protocol MYGestureCodeViewDelegate <NSObject>

@optional
- (void)gestureCodeViewDidFinishStroke:(MYGestureCodeView *)codeView;

@end
