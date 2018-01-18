//
//  ViewController.m
//  Download
//
//  Created by 陈伟捷 on 15/11/11.
//  Copyright © 2015年 chenweijie. All rights reserved.
//

#import "DownloadViewController.h"
#import "Download.h"
#import "DownloadManagment.h"
#import "SqliteManager.h"
#import "SSZipArchive.h"

@interface DownloadViewController ()

{
    CGFloat downloadSpeed;
}

@property (strong, nonatomic)  UILabel *progress;
@property (strong, nonatomic)  UILabel *speed;
@property (strong, nonatomic)  UILabel *savePath;

@property (nonatomic, strong)  Download *download;

@end

@implementation DownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadSubView];
    NSString *str = NSTemporaryDirectory();
    
    NSLog(@"%@", str);
    
    DownloadManagment *downloadManagment = [DownloadManagment shareDownloadManagment];
    
//    self.download = [[Download alloc]initWithURL:@"http://baobab.cdn.wandoujia.com/1447163643457322070435.mp4"];
    
    
    self.download = [downloadManagment addDownloadWithUrl:@"http://www.peikao.net/roger_files/PacteraFramework.framework.zip"];
    
    [_download resume];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(speed:) userInfo:nil repeats:YES];
    downloadSpeed = 0.0;
    
    [_download downloadFinish:^(NSString *savePath) {
        self.savePath.text = savePath;
        [timer invalidate];
    } downloading:^(float progress, float bytesWritten) {
        self.progress.text = [NSString stringWithFormat:@"%.2f%%", progress];
        downloadSpeed += bytesWritten / 1024;
    }];
    
}

- (void)loadSubView
{
    self.progress = [[UILabel alloc] init];
    self.progress.backgroundColor = [UIColor lightGrayColor];
    
    [self.contentView addSubview:self.progress];
    
    self.speed = [[UILabel alloc] init];
    self.speed.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.speed];
    
    self.savePath = [[UILabel alloc] init];
    self.savePath.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.savePath];
    
    UIButton *star = [UIButton buttonWithType:UIButtonTypeCustom];
    [star setTitle:@"开始" forState:UIControlStateNormal];
    star.backgroundColor = [UIColor lightGrayColor];
    [star addTarget:self action:@selector(resume:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:star];
    
    UIButton *stop = [UIButton buttonWithType:UIButtonTypeCustom];
    [stop setTitle:@"暂停" forState:UIControlStateNormal];
    stop.backgroundColor = [UIColor lightGrayColor];
    [stop addTarget:self action:@selector(suspend:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:stop];
    
    [star makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(70);
        make.size.equalTo(CGSizeMake(60, 40));
    }];
    
    [stop makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(star.top);
        make.right.equalTo(-70);
        make.size.equalTo(CGSizeMake(60, 40));
    }];
    
    [self.progress makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(star.left);
        make.top.equalTo(star.bottom).offset(20);
        make.height.equalTo(20);
        make.right.equalTo(-15);
    }];
    
    [self.speed makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(star.left);
        make.top.equalTo(self.progress.bottom).offset(20);
        make.height.equalTo(20);
        make.right.equalTo(-15);
    }];
    
    [self.savePath makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(star.left);
        make.top.equalTo(self.speed.bottom).offset(20);
        make.height.equalTo(20);
        make.right.equalTo(-15);
    }];
}

// 下载进度显示
- (void)speed:(NSTimer *)timer
{
    _speed.text = [NSString stringWithFormat:@"%0.2fkb/s", downloadSpeed];
    downloadSpeed = 0;
}

- (void)resume:(id)sender {
    [_download resume];
}

- (void)suspend:(id)sender {
    [_download suspend];
}


// 完成下载的代理方法
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    // 1.NSURL location 我们下载完成后的位置
    
    // 2.NSError 下载错误的信息
    
    // 1.把下载完成的文件转移走 不然会被系统删除
    NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    // downloadTask.response.suggestedFilename使用服务器使用的名字
    NSString *savePath = [cache stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    NSLog(@"%@", cache);
    // 2.创建NSFileManager,进行文件转移
    NSFileManager *fm = [NSFileManager defaultManager];
    // 3.转移文件(保存文件)
    [fm moveItemAtPath:location.path toPath:savePath error:nil];
    
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    // bytesWritten 本次下载字节数 下载速度
    
    // totalsBytesWritten 一共下载了多少的字节数
    
    // totalBytesExpectedToWrite 总字节数
    float progress =  (float)totalBytesWritten / totalBytesExpectedToWrite;
    NSLog(@"%f", progress);
}

@end
