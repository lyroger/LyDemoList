//
//  CommentHeadCell.h
//  DemoList
//
//  Created by Mac on 2018/6/11.
//  Copyright © 2018年 luoyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentData.h"

@interface CommentTableHeadView : UIView

- (void)model:(CommentData*)comment;
+ (CGFloat)getHeaderViewHeight:(CommentData*)comment;
@end
