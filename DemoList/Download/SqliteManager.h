//
//  SqliteManager.h
//  Download
//
//  Created by 陈伟捷 on 15/11/11.
//  Copyright © 2015年 chenweijie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "DownloadingManagment.h"
#import "DownloadManagmentFinish.h"

@interface SqliteManager : NSObject

+ (SqliteManager *)shareSqliteManager;

#pragma mark --- 打开数据库 ---
+ (sqlite3 *)openDB;

#pragma mark --- 关闭数据哭 ---
+ (void)closeDB;

#pragma mark --- 返回下载完成的数据 ---
+ (NSArray *)allDownloadFinish;

#pragma mark --- 返回所有下载中的数据 ---
+ (NSArray *)allDownloading;

#pragma mark --- 添加一个下载完成的数据(内部已实现对正在下载的删除) ---
+ (void)addDownloadFinishWithFinish:(DownloadManagmentFinish *)downloadManagmentFinish;

+ (void)addDownloadingWithDownloading:(DownloadingManagment *)downloading;

#pragma mark --- 根据url找到一个下载完成的数据 ---
+ (DownloadManagmentFinish *)findDownloadFinishWithURL:(NSString *)url;

#pragma mark --- 根据url找到下载中的数据 ---
+ (DownloadingManagment *)findDownloadingWithURL:(NSString *)url;

#pragma mark --- 根据url删除一个下载完成的数据 ---
+ (void)deleteDownloadFinishWithURL:(NSString *)url;

#pragma mark --- 根据url删除一个下载中的数据 ---
+ (void)deleteDownloadingWithURL:(NSString *)url;

#pragma mark --- 根据url改变一个下载中的进度显示 ---
+ (void)updataDownloadProgress:(float)progress URL:(NSString *)url;

+ (NSString *)documentsPathWithSqliteName:(NSString *)sqliteName;

@end
