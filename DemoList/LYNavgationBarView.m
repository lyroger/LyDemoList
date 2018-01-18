//
//  LYNavgationBarView.m
//  DemoList
//
//  Created by luoyan on 2018/1/18.
//  Copyright © 2018年 luoyan. All rights reserved.
//

#import "LYNavgationBarView.h"
@interface LYNavgationBarView()

@property (nonatomic, strong) UIButton *btnLeft;
@property (nonatomic, strong) UILabel  *labelTitle;


@end

@implementation LYNavgationBarView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kNavgationColor;
        [self addSubview:self.btnLeft];
        [self loadTitle];
        [self loadBottomLine];
    }
    return self;
}

- (UIButton*)btnLeft
{
    if (!_btnLeft) {
        _btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLeft.backgroundColor = kNavgationColor;
        _btnLeft.frame = CGRectMake(0,(self.frame.size.height-40)/2+8, 50, 40);
        [_btnLeft setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
        [_btnLeft setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [_btnLeft addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnLeft;
}

- (void)loadTitle
{
    if (!_labelTitle) {
        _labelTitle = [UILabel new];
        _labelTitle.font = [UIFont systemFontOfSize:18];
        _labelTitle.textAlignment = NSTextAlignmentCenter;
        _labelTitle.textColor = kFontBlackColor;
        _labelTitle.backgroundColor = kNavgationColor;
        [self addSubview:_labelTitle];
        
        [_labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_btnLeft.mas_right).mas_offset(5);
            make.centerX.mas_equalTo(self.centerX);
            make.top.mas_equalTo(@20);
            make.bottom.mas_equalTo(@0);
        }];
    }
}

- (void)loadBottomLine
{
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = kSplitLineColor;
    [self addSubview:bottomLine];
    
    [bottomLine makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(@0);
        make.height.mas_equalTo(@(0.6));
    }];
}

- (void)title:(NSString*)title
{
    self.labelTitle.text = title;
}

- (void)hideBackButton:(BOOL)hide
{
    self.btnLeft.hidden = hide;
}

- (void)clickButtonAction:(UIButton*)btn
{
    if (self.backBlock) {
        self.backBlock();
    }
}

@end
