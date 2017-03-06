//
//  CyclicCardCell.h
//  DemoList
//
//  Created by luoyan on 17/2/22.
//  Copyright © 2017年 luoyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CyclicCardCell : UICollectionViewCell

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UIImageView *cardImgView;
@property (nonatomic, strong) UILabel *cardNameLabel;

@end
