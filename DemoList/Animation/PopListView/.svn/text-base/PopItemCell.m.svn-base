//
//  PopItemCell.m
//  HappyDoctor
//
//  Created by luoyan on 15/9/15.
//  Copyright (c) 2015年 tcl. All rights reserved.
//

#import "PopItemCell.h"

@implementation PopItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = mRGBColor(66, 73, 79);
        float imageWidth = 16;
        self.imageIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, (mPopItemHeight-imageWidth)/2, imageWidth, imageWidth)];
        self.imageIcon.layer.masksToBounds = YES;
        self.imageIcon.clipsToBounds = YES;
        self.imageIcon.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:self.imageIcon];
        
        float orignX = 15+imageWidth+10;
        self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(orignX, 8, self.contentView.frame.size.width-orignX-10, 25)];
        self.labelTitle.font = [UIFont systemFontOfSize:15];
        self.labelTitle.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.labelTitle];
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
