//
//  PopListView.m
//  HappyDoctor
//
//  Created by luoyan on 15/9/15.
//  Copyright (c) 2015年 tcl. All rights reserved.
//

#import "PopListView.h"

@interface PopListView()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableViewList;
    NSArray     *dataArray;
    NSArray     *imageArray;
    CGRect      popFrame;
    CGPoint     popContentCenter;
    UIView      *popContentView;
    CAShapeLayer *arrowLayer;
}

@end

@implementation PopListView

- (id)initWithFrame:(CGRect)frame andDataList:(NSArray*)dataList andImageList:(NSArray*)imageNameList
{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        keyWindow.windowLevel = UIWindowLevelNormal;
        self.alpha = 0;
        [keyWindow addSubview:self];
        
        popFrame = frame;
        
        if (dataList) {
            dataArray = [[NSArray alloc] initWithArray:dataList];
        }
        if (imageNameList) {
            imageArray = [[NSArray alloc] initWithArray:imageNameList];
        }
        
        [self loadSubView];
    }
    
    return self;
}

- (void)showPopView
{
    self.alpha = 1;
}

- (void)hidePopView
{
    CGFloat animateTime = 0.3;
    NSString *animationOption = kCAMediaTimingFunctionEaseOut;
    
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    animation.fromValue = [NSNumber numberWithFloat:1];
    animation.toValue = [NSNumber numberWithFloat:0];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:animationOption];
    animation.duration = animateTime;
    
    POPBasicAnimation *animationScale = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    animationScale.toValue = [NSValue valueWithCGPoint:CGPointMake(0.1, 0.1)];
    animationScale.timingFunction = [CAMediaTimingFunction functionWithName:animationOption];
    animationScale.duration = animateTime;
    
    CGPoint top = CGPointMake(mScreenWidth-self.topPointMarginRight, 64);
    popContentCenter = popContentView.center;
    POPBasicAnimation *center = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    center.toValue = [NSValue valueWithCGPoint:top];
    center.timingFunction = [CAMediaTimingFunction functionWithName:animationOption];
    center.duration = animateTime;
    
    [popContentView pop_addAnimation:animation forKey:@"alpha"];
    [popContentView pop_addAnimation:animationScale forKey:@"Animation"];
    [popContentView pop_addAnimation:center forKey:@"center"];
    
    animation.completionBlock = ^(POPAnimation *anim, BOOL finished){
        if (finished) {
            self.alpha = 0;
            popContentView.alpha = 1;
            
            POPBasicAnimation *animationScaleOld = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
            animationScaleOld.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
            animationScaleOld.duration = 0;

            [popContentView pop_addAnimation:animationScaleOld forKey:@"Animationold"];
            animationScaleOld.completionBlock = ^(POPAnimation *anim, BOOL finished){
                if (finished) {
                    popContentView.center = popContentCenter;
                }
            };
        }
    };

}

- (void)setTopPointMarginRight:(CGFloat)topPointMarginRight
{
    _topPointMarginRight = topPointMarginRight;
    if (!arrowLayer) {
        arrowLayer = [CAShapeLayer layer];
        [popContentView.layer addSublayer:arrowLayer];
        
        CGPoint top = CGPointMake(popFrame.size.width-self.topPointMarginRight, 0);
        CGPoint bottomLeft = CGPointMake(popFrame.size.width-self.topPointMarginRight-6, 8);
        CGPoint bottomRight = CGPointMake(popFrame.size.width-self.topPointMarginRight+6, 8);
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:top];
        [bezierPath addLineToPoint:bottomLeft];
        [bezierPath addLineToPoint:bottomRight];
        [bezierPath addLineToPoint:top];
        
        arrowLayer.path = bezierPath.CGPath;
        arrowLayer.fillColor = mRGBColor(66, 73, 79).CGColor;
        arrowLayer.contentsScale = [UIScreen mainScreen].scale;
    }
}

- (void)loadSubView
{
    [self addTarget:self action:@selector(hidePopView) forControlEvents:UIControlEventTouchUpInside];
    
    popContentView = [[UIView alloc] initWithFrame:CGRectMake(popFrame.origin.x, popFrame.origin.y, popFrame.size.width, popFrame.size.height)];
    popContentView.layer.shadowOffset = CGSizeMake(4, 4);
    popContentView.layer.shadowOpacity = 0.8;
    popContentView.layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.4].CGColor;
    [self addSubview:popContentView];
    
    
    tableViewList = [[UITableView alloc] initWithFrame:CGRectMake(0, 8, popFrame.size.width-2, popFrame.size.height) style:UITableViewStylePlain];
    tableViewList.dataSource = self;
    tableViewList.delegate = self;
    tableViewList.scrollEnabled = NO;
    tableViewList.separatorColor = mRGBColor(91, 90, 93);
    tableViewList.layer.cornerRadius = 2;
    tableViewList.layer.masksToBounds = YES;
    [tableViewList registerClass:[PopItemCell class] forCellReuseIdentifier:@"cell"];
    [popContentView addSubview:tableViewList];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectPopListView:item:)]) {
        [self.delegate didSelectPopListView:self item:indexPath.row];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return mPopItemHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PopItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectedBackgroundView = [self getSelectBackView:cell];;
    cell.contentView.backgroundColor = mRGBColor(73, 72, 75);
    cell.labelTitle.text = [dataArray objectAtIndex:indexPath.row];
    if (indexPath.row < imageArray.count) {
        cell.imageIcon.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
    }
    return cell;
}

- (UIView*)getSelectBackView:(UITableViewCell*)cell
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 3, cell.contentView.frame.size.width, cell.contentView.frame.size.height-6)];
    backView.backgroundColor = mRGBColor(65, 64, 67);
    return backView;
}

#pragma mark 设置UITableView分割线靠左边距为0
-(void)layoutSubviews
{
    if ([tableViewList respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableViewList setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([tableViewList respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableViewList setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
