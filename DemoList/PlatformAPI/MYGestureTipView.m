//
//  MYGestureTipView.m
//  DSSPlatform
//
//  Created by yuan zhi on 4/8/13.
//  Copyright (c) 2013 yuan zhi. All rights reserved.
//

#import "MYGestureTipView.h"

@implementation MYGestureTipView
@synthesize passCode;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,frame.size.height - 20,frame.size.width,20)];
        tipLabel.text = @"绘制解锁图案";
        tipLabel.font = [UIFont systemFontOfSize:14.0f];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.textColor = [UIColor whiteColor];
        tipLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:tipLabel];
    }
    return self;
}

- (void)reset
{
    passCode = nil;
    tipLabel.text = @"绘制解锁图案";
    tipLabel.textColor = [UIColor whiteColor];
    [self setNeedsDisplay];
}

- (void)createFail
{
    tipLabel.text = @"图案前后不一致，请重新绘制！";
    tipLabel.textColor = [UIColor redColor];
}

- (void)setPassCode:(NSString *)passCode_
{
    tipLabel.text = @"再次绘制解锁图案";
    tipLabel.textColor = [UIColor whiteColor];
    passCode = [passCode_ copy];
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if (!passCode) {
        UIImage *image = [UIImage imageNamed:@"GesturesPatternDot_iPhone.png"];
        CGRect dotRect = CGRectMake(0, 0, 6, 6);
        for (int i = 0; i < 9; i++) {
            dotRect.origin.x = self.frame.size.width/2.0f - 15*(1 - i%3)-3;
            dotRect.origin.y = 15*(i/3);
            [image drawInRect:dotRect];
        }
    }
    else
    {
        NSArray *array = [self.passCode componentsSeparatedByString:@"|"];
        UIImage *image = [UIImage imageNamed:@"GesturesPatternDot_iPhone.png"];
        UIImage *dotImage = [UIImage imageNamed:@"GesturesPatternDot_yellow_iPhone.png"];
        CGRect dotRect = CGRectMake(0, 0, 6, 6);
        for (int i = 0; i < 9; i++) {
            dotRect.origin.x = self.frame.size.width/2.0f - 15*(1 - i%3)-3;
            dotRect.origin.y = 15*(i/3);
            BOOL isOn = NO;
            for (NSString *aStr in array) {
                if ([aStr intValue] == i) {
                    [dotImage drawInRect:dotRect];
                    isOn = YES;
                    break;
                }
            }
            if (!isOn) {
                [image drawInRect:dotRect];
            }
            
        }
    }
}

@end
