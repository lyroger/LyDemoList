//
//  PopListView.h
//  HappyDoctor
//
//  Created by luoyan on 15/9/15.
//  Copyright (c) 2015年 tcl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopItemCell.h"

@protocol DidSelectPopListView;

@interface PopListView : UIControl

- (id)initWithFrame:(CGRect)frame andDataList:(NSArray*)dataList andImageList:(NSArray*)imageNameList;
- (void)showPopView;
- (void)hidePopView;

@property (nonatomic,assign) CGFloat topPointMarginRight;
@property (nonatomic,assign) id<DidSelectPopListView> delegate;
@end

@protocol DidSelectPopListView <NSObject>

- (void)didSelectPopListView:(PopListView*)view item:(NSInteger)index;

@end