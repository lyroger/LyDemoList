//
//  LYAudioPalyerViewController.m
//  DemoList
//
//  Created by luoyan on 2018/1/15.
//  Copyright © 2018年 luoyan. All rights reserved.
//

#import "LYAudioPalyerViewController.h"
#import <AVKit/AVKit.h>

@interface LYAudioPalyerViewController ()

@property (nonatomic, strong) AVAudioPlayer * player;
@end

@implementation LYAudioPalyerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 80, 40);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"播放" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(startPlayingAudio) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startPlayingAudio
{
    NSURL *audioUrl  = [NSURL URLWithString:@"http://120.79.84.67:8080/api/sys/file/audioask62f816663effa67e8b85cf7869539a580faa3c0cf.m4a"];
    NSData *data = [NSData dataWithContentsOfURL:audioUrl];
    self.player = [[AVAudioPlayer alloc] initWithData:data error:nil];
    [self.player prepareToPlay];
    [self.player play];
}


@end
