//
//  AnimationViewController.m
//  DemoList
//
//  Created by 罗琰 on 16/1/2.
//  Copyright © 2016年 luoyan. All rights reserved.
//

#import "AnimationViewController.h"
#import "PopListView.h"

@interface AnimationViewController ()<DidSelectPopListView>
{
    UIView *scaleView;
    PopListView *popListView;
}

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadAnimateView];
    [self loadNavButton];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadAnimateView
{
    CGFloat width = 80;
    scaleView = [[UIView alloc] initWithFrame:CGRectMake((mScreenWidth-width)/2, 120, width, width)];
    scaleView.center = self.view.center;
    scaleView.backgroundColor = [UIColor redColor];
    scaleView.layer.cornerRadius = width/2;
    [self.view addSubview:scaleView];

    UIButton *btnAction = [UIButton buttonWithType:UIButtonTypeCustom];
    btnAction.frame = CGRectMake(10, 70, 50, 40);
    [btnAction setTitle:@"开始" forState:UIControlStateNormal];
    [btnAction setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnAction addTarget:self action:@selector(startAnimation) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnAction];
    
    UIButton *btn2Action = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2Action.frame = CGRectMake(80, 70, 50, 40);
    [btn2Action setTitle:@"停止" forState:UIControlStateNormal];
    [btn2Action setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2Action addTarget:self action:@selector(stopAnimation) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn2Action];
}

- (void)startAnimation
{
//    CABasicAnimation *annimation = [CABasicAnimation animationWithKeyPath:@"rotation.x"];
//    annimation.fromValue = @(1);
//    annimation.toValue = @(1.5);
//    annimation.duration = 1;
//    annimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//    annimation.repeatCount = CGFLOAT_MAX;
//    
//    [scaleView.layer addAnimation:annimation forKey:@"scaleAnimation"];
    
    
    CAKeyframeAnimation *keyframeAimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    keyframeAimation.values = @[@(1),@(1.5),@(1)];
    keyframeAimation.keyTimes = @[@(0),@(0.5),@(1)];
    keyframeAimation.duration = 2;
    keyframeAimation.fillMode = kCAFillModeForwards;
    keyframeAimation.removedOnCompletion = NO;
    keyframeAimation.repeatCount = CGFLOAT_MAX;
    keyframeAimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    
    
    [scaleView.layer addAnimation:keyframeAimation forKey:@"keyframe"];
}

- (void)stopAnimation
{
//    [scaleView.layer removeAnimationForKey:@"scaleAnimation"];
    [scaleView.layer removeAllAnimations];
}

- (void)moreFunction
{
    NSArray *dataList = @[@"加老师",@"加朋友",@"分享"];
    NSArray *imageList = @[@"icon_addFriend",@"icon_addFriend",@"icon_share"];
    if (!popListView) {
        popListView = [[PopListView alloc] initWithFrame:CGRectMake(mScreenWidth-121, 64, 120, mPopItemHeight*dataList.count) andDataList:dataList andImageList:imageList];
        popListView.delegate = self;
        popListView.topPointMarginRight = 24;
    }
    [popListView showPopView];
//    popListView.layer.
}

- (void)didSelectPopListView:(PopListView*)view item:(NSInteger)index
{
    NSLog(@"select Index = %zd",index);
    [popListView hidePopView];
}


- (void)loadNavButton
{
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(moreFunction)];
    self.navigationItem.rightBarButtonItem = addButton;
}


@end
