//
//  LYSearchDisplayController.m
//  DemoList
//
//  Created by luoyan on 16/1/27.
//  Copyright © 2016年 luoyan. All rights reserved.
//

#import "LYSearchDisplayController.h"

@interface LYSearchDisplayController()<UISearchDisplayDelegate>
{
    UIButton *btnVoice;
    UIButton *btnCancel;
    UIView   *searchBgView;
    CALayer  *topLineLayer;
    CALayer  *bottomLayer;
}

@property (nonatomic,weak)   UISearchBar      *mySearchBar;
@property (nonatomic,weak)   UIViewController *contentsController;
@property (nonatomic,strong) UIView *tempSearchDisplayBackgroungView;
@end

@implementation LYSearchDisplayController

- (instancetype)initWithSearchBar:(UISearchBar *)searchBar contentsController:(UIViewController *)viewController
{
    if ([super initWithSearchBar:searchBar contentsController:viewController]) {
        self.delegate = self;
        self.mySearchBar = searchBar;
        self.contentsController = viewController;
        if (!self.tempSearchDisplayBackgroungView) {
            self.tempSearchDisplayBackgroungView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight)];
            self.tempSearchDisplayBackgroungView.backgroundColor = [UIColor whiteColor];
            self.tempSearchDisplayBackgroungView.tag = 99;
            self.tempSearchDisplayBackgroungView.clipsToBounds = YES;
            self.tempSearchDisplayBackgroungView.userInteractionEnabled = NO;
            
            NSString *tips = @"搜索更多的内容";
            CGSize font = [tips sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
            UILabel *labelTips = [[UILabel alloc] initWithFrame:CGRectMake((mScreenWidth-font.width)/2, 50, font.width, font.height)];
            labelTips.font = [UIFont systemFontOfSize:20];
            labelTips.text = tips;
            labelTips.textColor = [UIColor colorWithWhite:0 alpha:0.5];
            [self.tempSearchDisplayBackgroungView addSubview:labelTips];
            
            CALayer *line = [CALayer layer];
            line.frame = CGRectMake(labelTips.frame.origin.x-30, labelTips.frame.origin.y+labelTips.frame.size.height+15, font.width+30*2, 0.5);
            line.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2].CGColor;
            line.opacity = 0.5;
            [self.tempSearchDisplayBackgroungView.layer addSublayer:line];
        }
    }
    return self;
}

- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
    topLineLayer.hidden = YES;
    bottomLayer.hidden = YES;
}

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    [self.searchBar setShowsCancelButton:YES animated:YES];
    UIButton *btn = [self.searchBar valueForKey:@"_cancelButton"];
    [btn setTitle:@"      " forState:UIControlStateNormal];
    //截屏
    UIImage *selfbg = [CommonFun snapshot:self.contentsController.view rect:CGRectMake(0, 0, mScreenWidth, mScreenHeight)];
    //模糊处理
    selfbg = [CommonFun accelerateBlurWithImage:selfbg];
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, mScreenWidth, mScreenHeight)];
    bgImage.image = selfbg;
    [self.tempSearchDisplayBackgroungView addSubview:bgImage];
    [self.tempSearchDisplayBackgroungView sendSubviewToBack:bgImage];
    
    [self performSelector:@selector(addTipsViewWithView:) withObject:controller afterDelay:0.1];
}

- (void)addTipsViewWithView:(UISearchDisplayController*)controller
{
    UIView *supV = controller.searchResultsTableView.superview;
    UIView *supsupV = supV.superview;
    
    for (UIView *view in supsupV.subviews) {
        for (UIView *sencondView in view.subviews) {
            if ([sencondView isKindOfClass:[NSClassFromString(@"_UISearchDisplayControllerDimmingView") class]])
            {
                NSLog(@"_UISearchDisplayControllerDimmingView");
                if (![sencondView viewWithTag:99]) {
                    [sencondView addSubview:self.tempSearchDisplayBackgroungView];
                }
                sencondView.alpha = 1;
            }
        }
    }
    
    if (!searchBgView) {
        for (UIView *subView in self.mySearchBar.subviews)
        {
            for (UIView *secondLevelSubview in subView.subviews){
                if ([secondLevelSubview isKindOfClass:[NSClassFromString(@"UISearchBarBackground") class]])
                {
                    [self addBgViewToView:secondLevelSubview];
                    break;
                }
            }
        }
    } else {
        topLineLayer.hidden = NO;
        bottomLayer.hidden = NO;
    }
}

- (void)addBgViewToView:(UIView*)view
{
    if (!searchBgView) {
        searchBgView = [[UIView alloc] init];
        searchBgView.tag = 100;
        searchBgView.backgroundColor = mRGBColor(239, 239, 244);
        [view addSubview:searchBgView];
        
        [searchBgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.left);
            make.right.equalTo(view.right);
            make.top.equalTo(view.top);
            make.bottom.equalTo(view.bottom);
        }];
        
        topLineLayer = [CALayer layer];
        topLineLayer.frame = CGRectMake(0, 20, mScreenWidth, 1);
        topLineLayer.backgroundColor = GrayWhiteColor.CGColor;
        [searchBgView.layer addSublayer:topLineLayer];
        
        bottomLayer = [CALayer layer];
        bottomLayer.frame = CGRectMake(0, 63, mScreenWidth, 1);
        bottomLayer.backgroundColor = GrayWhiteColor.CGColor;
        [searchBgView.layer addSublayer:bottomLayer];
    }
}
@end
