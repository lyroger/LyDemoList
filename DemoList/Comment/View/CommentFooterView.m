//
//  CommentFooterView.m
//  DemoList
//
//  Created by Mac on 2018/6/13.
//  Copyright © 2018年 luoyan. All rights reserved.
//

#import "CommentFooterView.h"

@implementation CommentFooterView

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        UIView *splitView = [UIView new];
        [self.contentView addSubview:splitView];
        splitView.backgroundColor = UIColorHex(0xe5e5e5);

        [splitView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(60);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(0.5);
            make.bottom.mas_equalTo(0);
        }];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
