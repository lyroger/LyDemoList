//
//  ReplyListCell.m
//  DemoList
//
//  Created by Mac on 2018/6/12.
//  Copyright © 2018年 luoyan. All rights reserved.
//

#import "ReplyListCell.h"

@interface ReplyListCell()

@property (nonatomic,strong) UILabel *labelName;
@property (nonatomic,strong) UILabel *labelCount;
@property (nonatomic,strong) UIButton *btnLike;
@property (nonatomic,strong) UILabel *labelContent;

@end

@implementation ReplyListCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = UIColorHex(0xf7f7f7);
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
        self.labelContent.font = [UIFont systemFontOfSize:15];
        self.labelContent.textColor = [UIColor darkTextColor];
        [self.contentView addSubview:self.labelContent];

        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(60);
            make.right.mas_equalTo(-15);
            make.top.bottom.mas_equalTo(0);
        }];
        //添加约束
        [self.labelName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(120);
        }];

        [self.btnLike mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(22, 22));
            make.centerY.mas_equalTo(self.labelName.mas_centerY);
        }];

        [self.labelCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.btnLike.mas_left).mas_offset(-2);
            make.centerY.mas_equalTo(self.btnLike.mas_centerY).mas_offset(2);;
        }];

        [self.labelContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.labelName.mas_bottom).mas_offset(10);
            make.left.mas_equalTo(self.labelName.mas_left);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(-10);
        }];
    }
    return self;
}

- (void)model:(ReplyList*)reply
{
    self.labelName.text = reply.nick;
    self.labelCount.text = [NSString stringWithFormat:@"%zd",reply.agreeCount];
    self.labelContent.text = reply.replyContent;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
