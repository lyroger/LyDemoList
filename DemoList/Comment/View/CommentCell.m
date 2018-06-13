//
//  CommentCell.m
//  DemoList
//
//  Created by Mac on 2018/6/11.
//  Copyright © 2018年 luoyan. All rights reserved.
//

#import "CommentCell.h"
#import "ReplyListCell.h"

@interface CommentCell()

@property (nonatomic,strong) UIImageView *imageHead;
@property (nonatomic,strong) UILabel *labelName;
@property (nonatomic,strong) UILabel *labelCount;
@property (nonatomic,strong) UIButton *btnLike;
@property (nonatomic,strong) UILabel *labelContent;
@property (nonatomic,strong) UILabel *labelAddressTimeInfo;
@property (nonatomic,strong) UIButton *btnReply;

@end

@implementation CommentCell

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.imageHead = [UIImageView new];
        self.imageHead.layer.cornerRadius = 22;
        self.imageHead.layer.masksToBounds = YES;
        [self.contentView addSubview:self.imageHead];

        self.labelName = [UILabel new];
        [self.contentView addSubview:self.labelName];

        self.labelCount = [UILabel new];
        self.labelCount.textColor = UIColorHex_Alpha(0x000000, 0.3);
        self.labelCount.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.labelCount];

        self.btnLike = [UIButton new];
        [self.btnLike setBackgroundImage:[UIImage imageNamed:@"news_fabulous"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.btnLike];

        self.labelContent = [UILabel new];
        self.labelContent.numberOfLines = 0;
        self.labelContent.textColor = [UIColor darkTextColor];
        [self.contentView addSubview:self.labelContent];

        self.labelAddressTimeInfo = [UILabel new];
        self.labelAddressTimeInfo.textColor = UIColorHex_Alpha(0x000000, 0.3);
        self.labelAddressTimeInfo.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.labelAddressTimeInfo];

        self.btnReply = [UIButton new];
        self.btnReply.layer.borderColor = UIColorHex_Alpha(0x000000, 0.2).CGColor;
        self.btnReply.layer.borderWidth = 1;
        self.btnReply.layer.cornerRadius = 12;
        [self.btnReply setTitleColor:UIColorHex_Alpha(0x000000, 0.3) forState:UIControlStateNormal];
        self.btnReply.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.btnReply setTitle:@"回复TA" forState:UIControlStateNormal];
        [self.contentView addSubview:self.btnReply];

        //添加约束
        [self.imageHead mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(15);
            make.height.width.mas_equalTo(44);
        }];

        [self.labelName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imageHead.mas_right).mas_offset(8);
            make.top.mas_equalTo(self.imageHead.mas_top);
        }];

        [self.btnLike mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(22, 22));
            make.top.mas_equalTo(self.imageHead.mas_top);
        }];

        [self.labelCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.btnLike.mas_left).mas_offset(-2);
            make.centerY.mas_equalTo(self.btnLike.mas_centerY).mas_offset(2);;
        }];

        [self.labelContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imageHead.mas_bottom).mas_offset(0);
            make.left.mas_equalTo(self.labelName.mas_left);
            make.right.mas_equalTo(-25);
        }];

        [self.labelAddressTimeInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.labelContent.mas_bottom).mas_offset(10);
            make.left.mas_equalTo(self.labelContent.mas_left);
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

- (void)model:(ReplyList*)reply
{
    [self.imageHead sd_setImageWithURL:[NSURL URLWithString:reply.headUrl] placeholderImage:nil];
    self.labelName.text = reply.nick;
    self.labelCount.text = [NSString stringWithFormat:@"%zd",reply.agreeCount];
    self.labelContent.text = reply.replyContent;
    self.labelAddressTimeInfo.text = [NSString stringWithFormat:@"%@·%zd",reply.provinceCity,reply.pubTime];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


@end
