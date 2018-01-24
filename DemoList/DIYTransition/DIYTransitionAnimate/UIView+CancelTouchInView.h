//
//  UIView+CancelTouchInView.h
//  DemoList
//
//  Created by luoyan on 2018/1/23.
//  Copyright © 2018年 luoyan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView(CancelTouchInView)
//导航栏全屏返回手势会与touchBegin event事件冲突，为了保证视图的touch事件正常响应，提供给视图该属性以控制手势的优先级高还是视图的优先级高。
//ly_cancelTouchInviewValue 该属性默认值为NO，即默认是响应返回手势的事件，若要响应视图的touch事件请设置该属性值为YES；
@property (nonatomic,assign) BOOL ly_cancelTouchInviewValue;

@end
