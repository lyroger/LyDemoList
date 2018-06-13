//
//  CommentCell.h
//  DemoList
//
//  Created by Mac on 2018/6/11.
//  Copyright © 2018年 luoyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReplyList.h"

@interface CommentCell : UITableViewHeaderFooterView

- (void)model:(ReplyList*)reply;

@end
