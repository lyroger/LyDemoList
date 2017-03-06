//
//  TransformViewController.m
//  DemoList
//
//  Created by luoyan on 17/3/2.
//  Copyright © 2017年 luoyan. All rights reserved.
//

#import "TransformViewController.h"

@interface TransformViewController ()


@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UILabel *myLabel;
@property (nonatomic, strong) CALayer *testLayer;
@property (nonatomic, strong) IBOutlet UIButton *myButton;

@end

@implementation TransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.image = [UIImage imageNamed:@"logo.jpg"];
//    CATransform3D transform = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 =  1.0 / 500.0;
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    self.imageView.layer.transform = transform;
    self.imageView.layer.shadowOpacity = 0.5f;
    self.imageView.layer.shadowOffset = CGSizeMake(0, 0);
    self.imageView.layer.shadowRadius = 5;
    
    
    CATransform3D labelRota = CATransform3DIdentity;
    labelRota.m34 =  1.0 / 500.0;
    labelRota = CATransform3DRotate(labelRota, M_PI_2, 0, 1, 0);
    self.myLabel.backgroundColor = [UIColor lightGrayColor];
    self.myLabel.layer.transform = labelRota;
    
    self.testLayer = [CALayer layer];
    self.testLayer.frame = CGRectMake(10, 70, 50, 50);
    self.testLayer.backgroundColor = [UIColor redColor].CGColor;
//    self.testLayer.contents = (__bridge id)[UIImage imageNamed:@"logo.jpg"].CGImage;
    
    [self.view.layer addSublayer:self.testLayer];
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    
    self.testLayer.actions = @{@"backgroundColor":transition};
    
//    testLayer.transform = labelRota;
    
//    self.myLabel.layer.transform
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)buttonClick:(id)sender
{
    //randomize the layer background color
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.testLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
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
