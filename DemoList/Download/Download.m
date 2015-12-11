//
//  Download.m
//  Download
//
//  Created by 陈伟捷 on 15/11/11.
//  Copyright © 2015年 chenweijie. All rights reserved.
//

#import "Download.h"
#import "DownloadingManagment.h"
#import "SqliteManager.h"
#import "DownloadManagmentFinish.h"

@interface Download ()

@property(nonatomic, strong)NSURLSessionDownloadTask *task;
@property(nonatomic, strong)NSURLSession *session;

@property(nonatomic, copy)DownloadFinish downloadFinish;
@property(nonatomic, copy)Downloading downloading;

@property(nonatomic, copy)DownloadCompleted downloadCompleted;

@end

@implementation Download

{
    BOOL _isFirst; // 第一次走下载进度的时候 进行暂停保存数据
}

- (void)dealloc
{
    NSLog(@"DownloadDealloc");
}

- (id)initWithURL:(NSString *)url
{
    self = [super init];
    if (self) {
        self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        
        self.task = [_session downloadTaskWithURL:[NSURL URLWithString:url]];
        
        _url = url;
        
        // 先去数据库中查找是否已经下载了 如果已经下载了 我们就把_isFirst赋值为yes 防止重复添加数据
        _isFirst =  [SqliteManager findDownloadingWithURL:url];
        
        if (_isFirst) {
            // 如果已经下载了 我们更换我们的task
            self.task = [self.session downloadTaskWithResumeData:[self resumeDataWithURL:url]];
        } 
    }
    return self;
}

- (NSData *)resumeDataWithURL:(NSString *)url
{
    // 1.找到下载中的model
    DownloadingManagment *downloading = [SqliteManager findDownloadingWithURL:url];
    // 给progress赋初始值
    _progress = downloading.progress;
    
    // 2.获取当前下载的文件
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSString *fileSize = [NSString stringWithFormat:@"%llu", [fm attributesOfItemAtPath:downloading.filePath error:nil].fileSize];
    
    // 3.对resumeDataStr进行替换
    downloading.resumeDataStr = [downloading.resumeDataStr stringByReplacingOccurrencesOfString:downloading.fileSize withString:fileSize];
    // 4.生成NSData进行返回
    return [downloading.resumeDataStr dataUsingEncoding:NSUTF8StringEncoding];
}

// 下载完成
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    /*
    // 下载完文件转走 不然会被系统删除
    // 获取沙盒路径
    NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    // downloadTask.response.suggestedFilename使用服务器的名字
    NSString *savePath = [cache stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    
    NSLog(@"%@\n%@", location.path, savePath);
    
    NSFileManager *fm = [NSFileManager defaultManager];
    // 转移文件（保存文件）
    [fm moveItemAtPath:location.path toPath:savePath error:nil];
    */
    //把下载完成的文件转移走。不然会被系统删除
    //1.获取沙盒路径
    NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    //downloadTask.response.suggestedFilename使用服务器使用的名字
    NSString *savePath = [cache stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    //2.创建NSFileManager,进行文件转移
    NSFileManager *fm = [NSFileManager defaultManager];
    //3.转移文件（保存文件）
    [fm moveItemAtPath:location.path toPath:savePath error:nil];
    
    
    // 保存数据库
    DownloadManagmentFinish *finish = [[DownloadManagmentFinish alloc]init];
    finish.url = self.url;
    finish.savePath = savePath;
    [SqliteManager addDownloadFinishWithFinish:finish];
    
    // block回调 添加一个判断 如果用户写了实现我就调用
    if (self.downloadFinish != nil) {
        self.downloadFinish(savePath);
    }
    // 下载完成以后 回调 目的是让单例不再持有该对象 从而可以删除
    if (self.downloadCompleted != nil) {
        self.downloadCompleted(_url);
    }
    [self.session finishTasksAndInvalidate];
}

- (void)resume
{
    [_task resume];
}

- (void)suspend
{
    [_task suspend];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    // 定义一个bool值 NO的时候进行暂停 暂停的时候 把resumeData解析保存 然后把值设置为YES 让他继续下载。就不会再走暂停方法了
    if (_isFirst == NO) {
        // 执行暂停方法
        [self cancelDownloadRask];
        _isFirst = YES;
    }
    
    float progress = (float)totalBytesWritten / totalBytesExpectedToWrite;
    
    _progress = progress * 100;
    
    // 对数据库中的下载进度做一个更新
    [SqliteManager updataDownloadProgress:progress * 100 URL:_url];
    
    if (self.downloading != nil) {
        self.downloading(progress * 100, (float)bytesWritten);
    }
}

// 暂停task的方法
- (void)cancelDownloadRask
{
    __weak typeof(self) blockSelf = self;
    [blockSelf.task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        // 解析保存 resumedata
        [self parsingResumeData:resumeData];
        // 继续下载
        blockSelf.task = [self.session downloadTaskWithResumeData:resumeData];
        [blockSelf.task resume];
    }];
}

// 解析保存的resumeData
- (void)parsingResumeData:(NSData *)resumeData
{
    NSString *resumeDataStr = [[NSString alloc]initWithData:resumeData encoding:NSUTF8StringEncoding];
    
    // 截取文件大小
    NSString *fileSize = [resumeDataStr componentsSeparatedByString:@"<key>NSURLSessionResumeBytesReceived</key>\n\t<integer>"].lastObject;
    fileSize = [fileSize componentsSeparatedByString:@"</integer>"].firstObject;
    
    // 截取filePath字符串
    NSString *filePath = [resumeDataStr componentsSeparatedByString:@"<key>NSURLSessionResumeInfoTempFileName</key>\n\t<string>"].lastObject;
    filePath = [filePath componentsSeparatedByString:@"</string>"].firstObject;
    
    NSString *tmp = NSTemporaryDirectory();
    filePath = [tmp stringByAppendingString:filePath];
    
    // Xcode6下的文件
    /*
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:filePath] == NO) {// 如果我们获取到的路径打不开 就换种解析方式
        filePath = [resumeDataStr componentsSeparatedByString:@"<key>NSURLSessionResumeInfoLocalPath</key>\n\t<string>"].lastObject;
        filePath = [filePath componentsSeparatedByString:@"<string>"].firstObject;
    }
    */
    
    // 进行数据保存
    DownloadingManagment *downloading = [[DownloadingManagment alloc]init];
    downloading.resumeDataStr = resumeDataStr;
    downloading.filePath = filePath;
    downloading.fileSize = fileSize;
    downloading.url = self.url;
    
    
    // 保存正在下载的数据库
    [SqliteManager addDownloadingWithDownloading:downloading];
    
    // 我们需要数据库保存当前的信息
    /**
     1.resumeDataStr (NSString) 保存我们resumeData数据 取出一个做转码
     2.filePath (NSString)      我们要找到文件的路径并且求出大小 做替换
     3.fileSize   (int)         保存暂停下载后的resumeData的中保存的文件大小 要知道和谁做替换
     4.progress (float)         下载的进度是多少了
     5.url  (NSString)          唯一标识 让我们知道在哪里能找到这条数据
     6.time  (double)           添加下载的时间戳(创建数据库的时候 都带上这个属性 一定会用到 比如我们要做一个排序)
     */
    
    // 下载完成需要的属性
    /**
     1.url  (NSString)          唯一标识 让我们知道在哪里能找到这条数据
     2.savePath (NSString)      保存的路径
     3.time   (double)          时间戳 用来排序
     */
}

- (void)downloadCompleted:(DownloadCompleted)completed
{
    self.downloadCompleted = completed;
}

- (void)downloadFinish:(DownloadFinish)downloadFinish downloading:(Downloading)downloading
{
    self.downloadFinish = downloadFinish;
    self.downloading = downloading;
}

@end







