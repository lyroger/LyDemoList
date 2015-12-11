//
//  Download.h
//  Download
//
//  Created by 陈伟捷 on 15/11/11.
//  Copyright © 2015年 chenweijie. All rights reserved.
//

#import <UIKit/UIKit.h>

// 下载完成后调用的block
typedef void(^DownloadFinish)(NSString *savePath);

// 下载中的block
typedef void(^Downloading)(float progress, float bytesWritten);

// 下载完成的时候调用（用户不要使用， 系统内部使用， 目的是使该对象被销毁 使用以后造成无法被销毁）
typedef void(^DownloadCompleted)(NSString *url);

@interface Download : NSObject <NSURLSessionDownloadDelegate>

@property(nonatomic, copy, readonly)NSString *url; // 返回该下载类的URL

@property(nonatomic, assign, readonly)float progress; // 返回当前下载的进度

// 根据URL创建一个下载类
- (id)initWithURL:(NSString *)url;

// 下载中的状态 block回调
- (void)downloadFinish:(DownloadFinish)downloadFinish downloading:(Downloading)downloading;

- (void)downloadCompleted:(DownloadCompleted)completed __deprecated_msg("⚠️使用此方法后 会造成内存泄露。此方法是内部使用的");

// 开始、继续
- (void)resume;
- (void)suspend;

@end
