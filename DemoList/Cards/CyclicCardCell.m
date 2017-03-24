//
//  CyclicCardCell.m
//  DemoList
//
//  Created by luoyan on 17/2/22.
//  Copyright © 2017年 luoyan. All rights reserved.
//

#import "CyclicCardCell.h"

@implementation CyclicCardCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor greenColor];
        self.layer.masksToBounds = true;
        self.layer.cornerRadius = 5.0;
        
        self.cardImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.width)];
        [self.contentView addSubview:self.cardImgView];
        
        self.cardNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.cardImgView.frame.origin.y+self.cardImgView.frame.size.height, self.cardImgView.frame.size.width, self.contentView.frame.size.height-self.cardImgView.frame.size.height)];

        self.cardNameLabel.textAlignment = NSTextAlignmentCenter;
        self.cardNameLabel.textColor = [UIColor blueColor];
        self.cardNameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.cardNameLabel];
    }
    return self;
}

@end
