//
//  LYMotionEffectVC.m
//  DemoList
//
//  Created by luoyan on 2018/1/8.
//  Copyright © 2018年 luoyan. All rights reserved.
//

#import "LYMotionEffectVC.h"

@interface LYMotionEffectVC ()

@end

@implementation LYMotionEffectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"WID-small.jpg"];
    imageView.frame = CGRectMake(-40, -20, CGRectGetWidth(self.view.frame)+40*2, CGRectGetHeight(self.view.frame)+20*2);
    [self.contentView addSubview:imageView];
    
    UILabel *tips = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 25)];
    tips.backgroundColor = [UIColor clearColor];
    tips.textColor = [UIColor whiteColor];
    tips.font = [UIFont boldSystemFontOfSize:20];
    tips.text = @"MotionEffect";
    tips.center = self.view.center;
    [self.contentView addSubview:tips];
    
    UIInterpolatingMotionEffect * xEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    xEffect.minimumRelativeValue =  [NSNumber numberWithFloat:-40.0];
    xEffect.maximumRelativeValue = [NSNumber numberWithFloat:40.0];
    
    UIInterpolatingMotionEffect * yEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    yEffect.minimumRelativeValue =  [NSNumber numberWithFloat:-20.0];
    yEffect.maximumRelativeValue = [NSNumber numberWithFloat:20.0];
    
    UIMotionEffectGroup *effectGroup = [UIMotionEffectGroup new];
    effectGroup.motionEffects = @[xEffect,yEffect];
    
    [imageView addMotionEffect:effectGroup];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
