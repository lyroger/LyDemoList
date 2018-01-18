//
//  AdScollViewController.m
//  DemoList
//
//  Created by luoyan on 15/12/2.
//  Copyright © 2015年 luoyan. All rights reserved.
//

#import "AdScollViewController.h"
#import "LYAdView.h"
#import "UIImageView+WebCache.h"

@interface AdScollViewController ()<LYAdViewDataSource,LYAdViewDelagate>
@property (nonatomic,strong) LYAdView *lyAdView;
@property (nonatomic,strong) NSArray *imageArray;
@end

@implementation AdScollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView  *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 1)];
    [self.contentView addSubview:view];
    
    _imageArray = @[@"http://f.hiphotos.baidu.com/image/pic/item/c9fcc3cec3fdfc03777a357fd03f8794a5c226f3.jpg",@"http://b.hiphotos.baidu.com/image/pic/item/d009b3de9c82d1580d1b8f76840a19d8bd3e4258.jpg",@"http://d.hiphotos.baidu.com/image/pic/item/6f061d950a7b02084052e92666d9f2d3562cc85a.jpg",@"http://e.hiphotos.baidu.com/image/pic/item/a6efce1b9d16fdfae3ebb2e3b68f8c5494ee7b33.jpg"];
    self.lyAdView = [[LYAdView alloc]initWithFrame:CGRectMake(0, (self.view.bounds.size.height-200)/2,self.view.bounds.size.width , 200)];
    self.lyAdView.delegate = self;
    self.lyAdView.dataSource = self;
    /**广告链接*/
    self.lyAdView.hidePageControl = NO;/**设置圆点是否隐藏*/
    self.lyAdView.adAutoPlay = YES;/**自动播放是否开启*/
    self.lyAdView.adPeriodTime = 4;/**时间间隔*/
    [self.lyAdView reloadAdView];
    [self.contentView addSubview:self.lyAdView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didClickPage:(LYAdView *)adView atIndex:(NSInteger)index;
{
    NSLog(@"didClickAdViewAtNum = %zd",index);
}

- (NSInteger)numberOfPages
{
    return _imageArray.count;
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    UIImageView *adImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    adImageView.contentMode = UIViewContentModeScaleToFill;
    NSURL *imageUrl = [NSURL URLWithString:[[NSString alloc] initWithFormat:@"%@",_imageArray[index]]];
    [adImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"banner1"]];
    return adImageView;
}

@end
