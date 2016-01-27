//
//  LYSearchBar.m
//  DemoList
//
//  Created by luoyan on 16/1/27.
//  Copyright © 2016年 luoyan. All rights reserved.
//

#import "LYSearchBar.h"

@interface LYSearchBar ()
{
    UIButton *btnCancel;
}

@end

@implementation LYSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnCancel setTitleColor:mRGBColor(78, 216, 101) forState:UIControlStateNormal];
        btnCancel.titleLabel.font = [UIFont systemFontOfSize:16];
        [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        
        [self setPlaceholder:@"搜索"];
        self.backgroundColor = mRGBColor(239, 239, 244);
        self.backgroundImage = [self imageFromColor:mRGBColor(239, 239, 244) frame:self.bounds];
        for (UIView *subView in self.subviews)
        {
            for (UIView *secondLevelSubview in subView.subviews){
                if ([secondLevelSubview isKindOfClass:[UITextField class]])
                {
                    UITextField *searchBarTextField = (UITextField *)secondLevelSubview;
                    searchBarTextField.backgroundColor = [UIColor whiteColor];
                    searchBarTextField.layer.borderColor =  mRGBColor(228, 229, 233).CGColor;
                    searchBarTextField.layer.borderWidth = 1;
                    searchBarTextField.layer.cornerRadius = 4;
                    searchBarTextField.tintColor = mRGBColor(78, 216, 101);
                    
                    [searchBarTextField.superview addSubview:btnCancel];
                    
                    [btnCancel makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(searchBarTextField.right).offset(-2);
                        make.centerY.equalTo(searchBarTextField.centerY);
                        make.size.equalTo(CGSizeMake(50, 30));
                    }];
                    break;
                }
            }
        }
    }
    return self;
}

- (UIImage *)imageFromColor:(UIColor *)color frame:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
@end
