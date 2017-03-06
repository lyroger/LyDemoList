//
//  LYCollectionViewCell.m
//  DemoList
//
//  Created by luoyan on 17/2/23.
//  Copyright © 2017年 luoyan. All rights reserved.
//

#import "LYCollectionViewCell.h"

@implementation LYCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

@end
