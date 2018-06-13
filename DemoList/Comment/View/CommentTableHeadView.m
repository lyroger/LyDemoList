//
//  CommentHeadCell.m
//  DemoList
//
//  Created by Mac on 2018/6/11.
//  Copyright © 2018年 luoyan. All rights reserved.
//

#import "CommentTableHeadView.h"

@interface CommentTableHeadView()

@property (nonatomic,strong) UIImageView *imageHead;
@property (nonatomic,strong) UILabel *labelName;
@property (nonatomic,strong) UILabel *labelCount;
@property (nonatomic,strong) UIButton *btnLike;
@property (nonatomic,strong) UILabel *labelContent;
@property (nonatomic,strong) UILabel *labelAddressTimeInfo;
@property (nonatomic,strong) UIButton *btnReply;

@end

@implementation CommentTableHeadView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColorHex(0xffffff);
        self.imageHead = [UIImageView new];
        self.imageHead.layer.cornerRadius = 22;
        self.imageHead.layer.masksToBounds = YES;
        [self addSubview:self.imageHead];

        self.labelName = [UILabel new];
        [self addSubview:self.labelName];

        self.labelCount = [UILabel new];
        self.labelCount.textColor = UIColorHex_Alpha(0x000000, 0.3);
        self.labelCount.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.labelCount];

        self.btnLike = [UIButton new];
        [self.btnLike setBackgroundImage:[UIImage imageNamed:@"news_fabulous"] forState:UIControlStateNormal];
        [self addSubview:self.btnLike];

        self.labelContent = [UILabel new];
        self.labelContent.numberOfLines = 0;
        self.labelContent.font = [UIFont systemFontOfSize:16];
        self.labelContent.textColor = [UIColor darkTextColor];
        [self addSubview:self.labelContent];

        self.labelAddressTimeInfo = [UILabel new];
        self.labelAddressTimeInfo.textColor = UIColorHex_Alpha(0x000000, 0.3);
        self.labelAddressTimeInfo.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.labelAddressTimeInfo];

        self.btnReply = [UIButton new];
        self.btnReply.layer.borderColor = UIColorHex_Alpha(0x000000, 0.2).CGColor;
        self.btnReply.layer.borderWidth = 1;
        self.btnReply.layer.cornerRadius = 12;
        [self.btnReply setTitleColor:UIColorHex_Alpha(0x000000, 0.3) forState:UIControlStateNormal];
        self.btnReply.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.btnReply setTitle:@"回复TA" forState:UIControlStateNormal];
        [self addSubview:self.btnReply];

        //添加约束
        [self.imageHead mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(15);
            make.height.width.mas_equalTo(44);
        }];

        [self.labelName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imageHead.mas_right).mas_offset(8);
            make.centerY.mas_equalTo(self.imageHead.mas_centerY);
        }];

        [self.btnLike mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(22, 22));
            make.centerY.mas_equalTo(self.imageHead.mas_centerY);
        }];

        [self.labelCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.btnLike.mas_left).mas_offset(-2);
            make.centerY.mas_equalTo(self.imageHead.mas_centerY).mas_offset(2);
        }];

        [self.labelContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imageHead.mas_bottom).mas_offset(10);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-10);
        }];

        [self.labelAddressTimeInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.labelContent.mas_bottom).mas_offset(10);
            make.left.mas_equalTo(15);
            make.bottom.mas_equalTo(-15);
        }];

        [self.btnReply mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.labelAddressTimeInfo.mas_right).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(56, 24));
            make.centerY.mas_equalTo(self.labelAddressTimeInfo.mas_centerY);
        }];
    }

    return self;
}

+ (CGFloat)getHeaderViewHeight:(CommentData*)comment
{
    NSString *content = comment.comments.orig.replyContent;
    CGFloat contentHeight = [content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-15*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height;

    return 15+44+10+contentHeight+10+24+10;
}

- (void)model:(CommentData*)comment
{
    [self.imageHead sd_setImageWithURL:[NSURL URLWithString:comment.comments.orig.headUrl] placeholderImage:nil];
    self.labelName.text = comment.comments.orig.nick;
    self.labelCount.text = [NSString stringWithFormat:@"%zd",comment.comments.orig.agreeCount];
    self.labelContent.text = comment.comments.orig.replyContent;
    self.labelAddressTimeInfo.text = [NSString stringWithFormat:@"%@·%zd",comment.comments.orig.provinceCity,comment.comments.orig.pubTime];
}

@end
