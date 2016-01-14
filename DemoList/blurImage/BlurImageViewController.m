//
//  BlurImageViewController.m
//  DemoList
//
//  Created by luoyan on 16/1/11.
//  Copyright © 2016年 luoyan. All rights reserved.
//
#import <Accelerate/Accelerate.h>
#import "BlurImageViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIImage+BlurImage.h"
#import <objc/runtime.h>

@interface BlurImageViewController ()
{
    UIImageView *blurImageView;
    UISlider *imageSlider;
    ALAssetsLibrary *_library;
    UIImage *selectImage;
    UIImage *blurImage;
}

@end

@implementation BlurImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"blurImage";
    selectImage = [UIImage imageNamed:@"mypic.jpg"];
    blurImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    blurImageView.image = selectImage;
    [self.view addSubview:blurImageView];
    
    imageSlider = [[UISlider alloc] initWithFrame:CGRectMake(15.0, mScreenHeight - 50.0, mScreenWidth - 100.0, 40.0)];
    [imageSlider addTarget:self action:@selector(updateSliderValue:) forControlEvents:UIControlEventValueChanged];
    imageSlider.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    imageSlider.minimumValue = 0;
    imageSlider.maximumValue = 2.0;
    imageSlider.value = 0.0;
    
    UIButton *chooseFile = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseFile.frame = CGRectMake(imageSlider.frame.origin.x+imageSlider.frame.size.width+10, imageSlider.frame.origin.y, 80, 40);
    [chooseFile setTitle:@"选择文件" forState:UIControlStateNormal];
    [chooseFile addTarget:self action:@selector(chooseImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chooseFile];
    
    
    [self.view addSubview:imageSlider];
    blurImageView.image = selectImage;
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAction)];
    
}

- (void)chooseImage
{
    
}

- (void)saveAction
{
    if (!_library) {
        _library = [[ALAssetsLibrary alloc]init];
    }
    [_library writeImageToSavedPhotosAlbum:[blurImage CGImage] orientation:ALAssetOrientationUp completionBlock:^(NSURL *assetURL, NSError *error) {
        if (!error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"成功加入相册" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateSliderValue:(id)sender
{
    CGFloat midpoint = [(UISlider *)sender value];
    blurImage = [selectImage blurredImageWithRadius:midpoint*10*10];
    blurImageView.image = blurImage;
}

@end
