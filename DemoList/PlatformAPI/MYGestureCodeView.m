//
//  MYGestureCodeView.m
//  DSSPlatform
//
//  Created by James on 13-4-3.
//  Copyright (c) 2013年 mysoft. All rights reserved.
//

#import "MYGestureCodeView.h"
#import <QuartzCore/QuartzCore.h>

#define POINT_NO 9

CGRect squareRect(CGPoint center, CGFloat size) {
    CGFloat halfSize = size / 2.0;
    return CGRectMake(center.x - halfSize, center.y - halfSize, size, size);
}

CGFloat distance(CGPoint point1, CGPoint point2) {
    CGFloat value = powf((point2.x - point1.x), 2) + powf((point2.y - point1.y), 2);
    return sqrtf(value);
}

@interface MYGestureCodeView () {
    CGPoint itemLocations_[POINT_NO];
    CGPoint currentPoint_;
    int status_[POINT_NO];
    int pathIndex_[POINT_NO];
    BOOL done_;
}

@property (nonatomic, assign) BOOL done;

- (void)initItemLocations;

- (int)hitItem:(CGPoint)point;

- (BOOL)addPathWithIndex:(int)index;

@end

@implementation MYGestureCodeView

@synthesize checkItemSize = checkItemSize_;
@synthesize itemBackgroundImage = itemBackgroundImage_;
@synthesize checkImage = checkImage_;
@synthesize uncheckImage = uncheckImage_;
@synthesize warningImage = warningImage_;
@synthesize strokeColor = strokeColor_;
@synthesize warningColor = warningColor_;
@synthesize strokeLineWidth = strokeLineWidth_;
@synthesize code = code_;
@synthesize done = done_;
@synthesize delegate = delegate_;
@synthesize codeMatch = codeMatch_;
@synthesize passCode = passCode_;
@synthesize warning = warning_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        checkItemSize_ = 65;
        
        warningColor_ = [UIColor redColor];
        strokeColor_ = [UIColor greenColor];
        strokeLineWidth_ = 3.0f;
        
        [self initItemLocations];
        
        for (int i = 0; i < POINT_NO; i++) {
            status_[i] = -1;
            pathIndex_[i] = -1;
        }
        
        self.done = NO;
        codeMatch_ = MYGestureCodeViewCodeNotSetup;
    }
    return self;
}

- (void)setWarning:(BOOL)warning {
    if (warning_ != warning) {
        warning_ = warning;
        
        if (warning_) {
            [self performSelector:@selector(reset) withObject:nil afterDelay:0.4];
        }
        
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextClearRect(context, rect);
    
    CGContextSetLineWidth(context, strokeLineWidth_);
    if (!warning_) {
        CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor);
    }
    else
    {
        CGContextSetStrokeColorWithColor(context, self.warningColor.CGColor);
    }
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    if (-1 != pathIndex_[0]) {
        CGContextMoveToPoint(context, itemLocations_[pathIndex_[0]].x, itemLocations_[pathIndex_[0]].y);
        
        for (int i = 0; i < POINT_NO; i++) {
            
            if (-1 != pathIndex_[i]) {
                CGContextAddLineToPoint(context, itemLocations_[pathIndex_[i]].x, itemLocations_[pathIndex_[i]].y);
            } else {
                break;
            }
        }
        
        if (!self.done) {
            CGContextAddLineToPoint(context, currentPoint_.x, currentPoint_.y);
        }
        
        CGContextStrokePath(context);
    }
    
    CGRect itemRect = CGRectZero;
    CGFloat size = 0;
    
    for (int i = 0; i < POINT_NO; i++) {
        if (self.itemBackgroundImage) {
            size = self.itemBackgroundImage.size.width;
            itemRect = squareRect(itemLocations_[i], size > checkItemSize_ ? checkItemSize_ : size);
            [self.itemBackgroundImage drawInRect:itemRect];
        }
        
        if (!status_[i]) { // check
            if (!warning_ && self.checkImage) {
                size = self.checkImage.size.width;
                itemRect = squareRect(itemLocations_[i], size > checkItemSize_ ? checkItemSize_ : size);
                [self.checkImage drawInRect:itemRect];
            }
            else if (warning_ && self.warningImage)
            {
                size = self.warningImage.size.width;
                itemRect = squareRect(itemLocations_[i], size > checkItemSize_ ? checkItemSize_ : size);
                [self.warningImage drawInRect:itemRect];
            }
        } else { // uncheck
            if (self.uncheckImage) {
                size = self.uncheckImage.size.width;
                itemRect = squareRect(itemLocations_[i], size > checkItemSize_ ? checkItemSize_ : size);
                [self.uncheckImage drawInRect:itemRect];
            }
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    if (self.done) { return; }
    
    CGPoint point = [(UITouch *)[touches anyObject] locationInView:self];
    currentPoint_ = point;
    
    int item = [self hitItem:point];
    if (-1 != item) { [self addPathWithIndex:item]; }
    
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    if (self.done) { return; }
    
    CGPoint point = [(UITouch *)[touches anyObject] locationInView:self];
    currentPoint_ = point;
    
    int item = [self hitItem:point];
    if (-1 != item) { [self addPathWithIndex:item]; }
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    if (self.done) { return; }
    
    CGPoint point = [(UITouch *)[touches anyObject] locationInView:self];
    currentPoint_ = point;
    
    int item = [self hitItem:point];
    if (-1 != item) { [self addPathWithIndex:item]; }
    
    [self setNeedsDisplay];
    
    if (-1 !=pathIndex_[0]) { self.done = YES; }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
}

- (void)reset {
    for (int i = 0; i < POINT_NO; i++) {
        status_[i] = -1;
        pathIndex_[i] = -1;
    }
    
    self.warning = NO;
    self.done = NO;
    
    codeMatch_ = MYGestureCodeViewCodeNotSetup;
    
    [self setNeedsDisplay];
}

#pragma mark - getter and setter

- (void)setDone:(BOOL)done {
    if (done_ != done) {
        done_ = done;
        
        if (done) {
            code_ = [NSString stringWithFormat:@"%d|%d|%d|%d|%d|%d|%d|%d|%d",
                     pathIndex_[0], pathIndex_[1], pathIndex_[2],
                     pathIndex_[3], pathIndex_[4], pathIndex_[5],
                     pathIndex_[6], pathIndex_[7], pathIndex_[8]];
            
            if ([self.delegate respondsToSelector:@selector(gestureCodeViewDidFinishStroke:)]) {
                [self.delegate gestureCodeViewDidFinishStroke:self];
            }
            
            if (self.passCode) {
                if ([self.passCode isEqualToString:code_]) {
                    codeMatch_ = MYGestureCodeViewCodeMatch;
                } else {
                    codeMatch_ = MYGestureCodeViewCodeNotMatch;
                }
            }
        } else {
            code_ = nil;
        }
    }
}

#pragma mark - private API

- (void)initItemLocations {    
    if (CGRectGetWidth(self.bounds) < 3 * self.checkItemSize || CGRectGetHeight(self.bounds) < 3 * self.checkItemSize) {
        for (int i = 0; i < POINT_NO; i++) {
            itemLocations_[i] = CGPointZero;
        }
    } else {
        CGFloat d = self.checkItemSize / 2.0;
        
        itemLocations_[0] = CGPointMake(CGRectGetMinX(self.bounds) + d, CGRectGetMinY(self.bounds) + d);
        itemLocations_[1] = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMinY(self.bounds) + d);
        itemLocations_[2] = CGPointMake(CGRectGetMaxX(self.bounds) - d, CGRectGetMinY(self.bounds) + d);
        
        itemLocations_[3] = CGPointMake(CGRectGetMinX(self.bounds) + d, CGRectGetMidY(self.bounds));
        itemLocations_[4] = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        itemLocations_[5] = CGPointMake(CGRectGetMaxX(self.bounds) - d, CGRectGetMidY(self.bounds));
        
        itemLocations_[6] = CGPointMake(CGRectGetMinX(self.bounds) + d, CGRectGetMaxY(self.bounds) - d);
        itemLocations_[7] = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMaxY(self.bounds) - d);
        itemLocations_[8] = CGPointMake(CGRectGetMaxX(self.bounds) - d, CGRectGetMaxY(self.bounds) - d);
    }
}

- (int)hitItem:(CGPoint)point {
    int ret = -1;
    
    CGRect tmpRect = CGRectZero;
    CGFloat size = checkItemSize_ > self.itemBackgroundImage.size.width ? self.itemBackgroundImage.size.width:checkItemSize_;
    for (int i = 0; i < POINT_NO; i++) {
        tmpRect = squareRect(itemLocations_[i], size);
        
        if (CGRectContainsPoint(tmpRect, point)) {
            ret = i;
            break;
        }
    }
    
    if (-1 == ret && -1 != pathIndex_[0]) {
        
        int lastPointIndex = -1;
        
        for (int i = 1; i < POINT_NO; i++) {
            if (-1 == pathIndex_[i]) {
                lastPointIndex = i - 1;
                break;
            }
        }
        
        if (lastPointIndex >= 0) {
            CGPoint lastPoint = itemLocations_[pathIndex_[lastPointIndex]];
            
            for (int i = 0; i < POINT_NO; i++) {
                if (-1 == status_[i]) {
                    CGPoint p = itemLocations_[i];
                    
                    CGFloat d1 = distance(p, lastPoint);
                    CGFloat d2 = distance(p, point);
                    CGFloat d3 = distance(point, lastPoint);
                    CGFloat a = (d1 + d2) / d3;
                                        
                    if (a > 1.0 && a < 1.02) {
                        ret = i;
                        break;
                    }
                }
            }
        }
    }
        
    return ret;
}

- (BOOL)addPathWithIndex:(int)index {
    BOOL ret = false;
    
    if (index < 0 || index >= POINT_NO) {
        return ret;
    }
    
    for (int i = 0; i < POINT_NO; i++) {
        if (-1 == pathIndex_[i] && -1 == status_[index]) {
            pathIndex_[i] = index;
            status_[index] = 0;
            break;
        }
    }
    
    return ret;
}

@end
