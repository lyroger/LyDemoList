//
//  SqliteManager.m
//  Download
//
//  Created by 陈伟捷 on 15/11/11.
//  Copyright © 2015年 chenweijie. All rights reserved.
//

#import "SqliteManager.h"
#import "DownloadManagmentFinish.h"

static sqlite3 *db = nil;

@implementation SqliteManager

+ (SqliteManager *)shareSqliteManager
{
    static SqliteManager *sql = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sql = [[SqliteManager alloc]init];
    });
    return sql;
}

#pragma mark --- 打开数据库 第一次为创建 ---
+ (sqlite3 *)openDB
{
    if (db != nil) {
        return db;
    }
    
    NSString *filePath = [SqliteManager documentsPathWithSqliteName:@"DownloadManagment.sqlite"];
    
    // 判断该目录下是否有文件 如果没有 我们把工程中的copy过来也可以自己创建一个
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:filePath] == NO) {// 如果没有
        NSString *boundlePath = [[NSBundle mainBundle] pathForResource:@"DownloadManagment" ofType:@"sqlite"];
        [fm copyItemAtPath:boundlePath toPath:filePath error:nil];
    }
    
    sqlite3_open([filePath UTF8String], &db);
    
    return db;
}

#pragma mark --- 关闭数据哭 ---
+ (void)closeDB
{
    sqlite3_close(db);
    db = nil;
}

#pragma mark --- 返回正在下载的数据 ---
+ (NSArray *)allDownloading
{
    db = [SqliteManager openDB];
    sqlite3_stmt *stmt = nil;
    
    // 创建我们的数据
    NSMutableArray *array = nil;
    
    int result = sqlite3_prepare_v2(db, [@"select from download" UTF8String], -1, &stmt, nil);
    
    if (result == SQLITE_OK) {
        array = [NSMutableArray array];
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            const unsigned char *cRecumeDataStr = sqlite3_column_text(stmt, 0);
            NSString *recumeDataStr = [NSString stringWithUTF8String:(const char *)cRecumeDataStr];
            
            const unsigned char *cFilePath = sqlite3_column_text(stmt, 1);
            NSString *filePath = [NSString stringWithUTF8String:(const char *)cFilePath];
            
            const unsigned char *cFileSize = sqlite3_column_text(stmt, 2);
            NSString *fileSize = [NSString stringWithUTF8String:(const char *)cFileSize];
            
            float progress = sqlite3_column_double(stmt, 3);
            
            const unsigned char *cUrl = sqlite3_column_text(stmt, 4);
            NSString *url = [NSString stringWithUTF8String:(const char *)cUrl];
            
            double time = sqlite3_column_double(stmt, 5);
            
            DownloadingManagment *downloading = [[DownloadingManagment alloc]init];
            NSDictionary *dic = @{@"recumeDataStr":recumeDataStr, @"filePath":filePath, @"fileSize":fileSize, @"progress":@(progress), @"url":url, @"time":@(time)};
            [downloading setValuesForKeysWithDictionary:dic];
            [array addObject:downloading];
        }
    }
    sqlite3_finalize(stmt);
    
    [SqliteManager closeDB];
    
    return array;
}

#pragma mark --- 返回所有下载完成的数据 ---
+ (NSArray *)allDownloadFinish
{
    db = [SqliteManager openDB];
    sqlite3_stmt *stmt = nil;
    
    // 创建我们的数据
    NSMutableArray *array = nil;
    
    int result = sqlite3_prepare_v2(db, [@"select * from downloadCompleted" UTF8String], -1, &stmt, nil);
    
    if (result == SQLITE_OK) {
        array = [NSMutableArray array];
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            const unsigned char *cUrl = sqlite3_column_text(stmt, 0);
            NSString *url = [NSString stringWithUTF8String:(const char *)cUrl];
            
            const unsigned char *cFilePath = sqlite3_column_text(stmt, 1);
            NSString *filePath = [NSString stringWithUTF8String:(const char *)cFilePath];
            
            double time = sqlite3_column_double(stmt, 2);
            
            DownloadManagmentFinish *downloadingFinish = [[DownloadManagmentFinish alloc]init];
            NSDictionary *dic = @{@"filePath":filePath, @"url":url, @"time":@(time)};
            [downloadingFinish setValuesForKeysWithDictionary:dic];
            [array addObject:downloadingFinish];
        }
    }
    sqlite3_finalize(stmt);
    
    [SqliteManager closeDB];
    
    return array;
}

#pragma mark --- 添加一个下载完成的数据(内部已实现对正在下载的删除) ---
+ (void)addDownloadFinishWithFinish:(DownloadManagmentFinish *)downloadManagmentFinish
{
    db = [SqliteManager openDB];
    // 求出当前的时间戳
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSString *sql = [NSString stringWithFormat:@"insert into downloadCompleted values('%@', '%@', %f)", downloadManagmentFinish.url, downloadManagmentFinish.savePath, time];
    // 执行sql语句
    sqlite3_exec(db, [sql UTF8String], nil, nil, nil);
    
    // 下载完成后删除一条正在下载的数据
    [SqliteManager deleteDownloadingWithURL:downloadManagmentFinish.url];
    
    [SqliteManager closeDB];
}

#pragma mark --- 添加一个下载中的数据 ---
+ (void)addDownloadingWithDownloading:(DownloadingManagment *)downloading
{
    db = [SqliteManager openDB];
    // 求出当前的时间戳
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSString *sql = [NSString stringWithFormat:@"insert into download values ('%@', '%@', '%@', %f, '%@', %f)", downloading.resumeDataStr, downloading.filePath, downloading.fileSize, downloading.progress, downloading.url, time];
    sqlite3_exec(db, [sql UTF8String], nil, nil, nil);
    
    [SqliteManager closeDB];
}

#pragma mark --- 根据url找到一个下载完成的数据 ---
+ (DownloadManagmentFinish *)findDownloadFinishWithURL:(NSString *)url
{
    db = [SqliteManager openDB];
    sqlite3_stmt *stmt = nil;
    
    // 创建我们的数据
    DownloadManagmentFinish *downloadingFinish = nil;
    
    NSString *sql = [NSString stringWithFormat:@"select * from downloadCompleted where url = '%@'", url];
    
    int result = sqlite3_prepare(db, [sql UTF8String], -1, &stmt, nil);
    
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            const unsigned char *cUrl = sqlite3_column_text(stmt, 0);
            NSString *url = [NSString stringWithUTF8String:(const char *)cUrl];
            
            const unsigned char *cSavePath = sqlite3_column_text(stmt, 1);
            NSString *savePath = [NSString stringWithUTF8String:(const char *)cSavePath];
            
            double time = sqlite3_column_double(stmt, 2);
            
            downloadingFinish = [[DownloadManagmentFinish alloc]init];
            
            NSDictionary *dic = @{@"savePath":savePath, @"url":url, @"time":@(time)};
            
            [downloadingFinish setValuesForKeysWithDictionary:dic];
        }
    }
    sqlite3_finalize(stmt);
    
    [SqliteManager closeDB];
    
    return downloadingFinish;
}

#pragma mark --- 根据url找到下载中的数据 ---
+ (DownloadingManagment *)findDownloadingWithURL:(NSString *)url
{
    db = [SqliteManager openDB];
    sqlite3_stmt *stmt = nil;
    
    // 创建我们的数据
    DownloadingManagment *downloading = nil;
    
    NSString *sql = [NSString stringWithFormat:@"select * from download where url = '%@'", url];
    
    int result = sqlite3_prepare(db, [sql UTF8String], -1, &stmt, nil);
    
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            downloading = [[DownloadingManagment alloc]init];
            
            const unsigned char *cResumeDataStr = sqlite3_column_text(stmt, 0);
            NSString *resumeDataStr = [NSString stringWithUTF8String:(const char *)cResumeDataStr];
            downloading.resumeDataStr = resumeDataStr;
            
            const unsigned char *cFilePath = sqlite3_column_text(stmt, 1);
            NSString *filePath = [NSString stringWithUTF8String:(const char *)cFilePath];
            downloading.filePath = filePath;
            
            const unsigned char *cFileSize = sqlite3_column_text(stmt, 2);
            NSString *fileSize = [NSString stringWithUTF8String:(const char *)cFileSize];
            downloading.fileSize = fileSize;
            
            float progress = sqlite3_column_double(stmt, 3);
            downloading.progress = progress;
            
            const unsigned char *cUrl = sqlite3_column_text(stmt, 4);
            NSString *url = [NSString stringWithUTF8String:(const char *)cUrl];
            downloading.url = url;
            
            double time = sqlite3_column_double(stmt, 5);
            downloading.time = time;
            
        }
    }
    sqlite3_finalize(stmt);
    
    [SqliteManager closeDB];
    
    return downloading;
}

#pragma mark --- 根据url删除一个下载完成的数据 ---
+ (void)deleteDownloadFinishWithURL:(NSString *)url
{
    db = [SqliteManager openDB];
    
    // 除了删除数据库中的内容还要删除文件
    DownloadManagmentFinish *finish = [SqliteManager findDownloadFinishWithURL:url];
    [[NSFileManager defaultManager] removeItemAtPath:finish.savePath error:nil];
    
    NSString *sql = [NSString stringWithFormat:@"delete from downloadCompleted where url = '%@'", url];
    sqlite3_exec(db, [sql UTF8String], nil, nil, nil);
    [SqliteManager closeDB];
}

#pragma mark --- 根据url删除一个下载中的数据 ---
+ (void)deleteDownloadingWithURL:(NSString *)url
{
    db = [SqliteManager openDB];
    
    NSString *sql = [NSString stringWithFormat:@"delete from download where url = '%@'", url];
    sqlite3_exec(db, [sql UTF8String], nil, nil, nil);
    [SqliteManager closeDB];
}

#pragma mark --- 根据url改变一个下载中的进度显示 ---
+ (void)updataDownloadProgress:(float)progress URL:(NSString *)url
{
    db = [SqliteManager openDB];
    NSString *sql = [NSString stringWithFormat:@"update download set progress = %f where url = '%@'", progress, url];
    sqlite3_exec(db, [sql UTF8String], nil, nil, nil);
    [SqliteManager closeDB];
}

+ (NSString *)documentsPathWithSqliteName:(NSString *)sqliteName
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:sqliteName];
}

@end
