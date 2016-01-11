//
//  AnimationHomeViewController.m
//  DemoList
//
//  Created by luoyan on 16/1/4.
//  Copyright © 2016年 luoyan. All rights reserved.
//

#import "AnimationHomeViewController.h"

@interface AnimationHomeViewController ()

@property (strong) CALayer *colorLayer;
@property (nonatomic,strong) UIView *colorView;
@end

@implementation AnimationHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50.0f, 70.0f, 100.0f, 100.0f);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    //add it to our view
    [self.view.layer addSublayer:self.colorLayer];
    
    self.colorView = [[UIView alloc] initWithFrame:CGRectMake(50.0f, 190.0f, 100.0f, 100.0f)];
    self.colorView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.colorView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(200, 120, 100, 40);
    [button setTitle:@"开始" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeColor) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeColor
{
//    [CATransaction begin];
//    [CATransaction setAnimationDuration:3];

    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 2;
    
    //randomize the layer background color
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    

    
    self.colorView.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
//        [CATransaction commit];

    [self.colorView.layer addAnimation:animation forKey:@"animation"];
}

@end
