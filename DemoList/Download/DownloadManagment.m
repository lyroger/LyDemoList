
//
//  DownloadManagment.m
//  Download
//
//  Created by 陈伟捷 on 15/11/11.
//  Copyright © 2015年 chenweijie. All rights reserved.
//

#import "DownloadManagment.h"

@interface DownloadManagment  ()

@property(nonatomic, strong)NSMutableDictionary *downloadDic;

@end

@implementation DownloadManagment

+ (instancetype)shareDownloadManagment
{
    static DownloadManagment *downloadManagment = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downloadManagment = [[DownloadManagment alloc]init];
    });
    return downloadManagment;
}

// 初始化方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.downloadDic = [NSMutableDictionary dictionary];
    }
    return self;
}

// 根据URL添加一个下载类
- (Download *)addDownloadWithUrl:(NSString *)url
{
    // 先从字典里面取到对应的下载
    Download *download = self.downloadDic[url];
    if (download == nil) {// 如果字典里面没有 我们就创建一个
        download = [[Download alloc]initWithURL:url];
        //添加到我们的字典当中
        [self.downloadDic setObject:download forKey:url];
    }
    // 下载完成以后 让单例不再持有着下载类 从字典里面移除
    [download downloadCompleted:^(NSString *url) {
        [self.downloadDic removeObjectForKey:url];
        NSLog(@"下载完成");
    }];
    return download;
}

// 根据URL找到一个下载类
- (Download *)findDownloadWithURL:(NSString *)url
{
    return self.downloadDic[url];
}

// 返回所有正在下载的类
- (NSArray *)allDownlod
{
    return [self.downloadDic allValues];
}


@end
