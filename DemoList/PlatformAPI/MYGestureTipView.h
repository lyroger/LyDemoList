//
//  MYGestureTipView.h
//  DSSPlatform
//
//  Created by yuan zhi on 4/8/13.
//  Copyright (c) 2013 yuan zhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYGestureTipView : UIView
{
    UILabel *tipLabel;
}
//手势密码
@property (nonatomic, copy) NSString *passCode;

- (void)reset;
- (void)createFail;

@end
