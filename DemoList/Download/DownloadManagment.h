//
//  DownloadManagment.h
//  Download
//
//  Created by 陈伟捷 on 15/11/11.
//  Copyright © 2015年 chenweijie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Download.h"


@interface DownloadManagment : NSObject


+ (instancetype)shareDownloadManagment;

// 根据URL添加一个下载类
- (Download *)addDownloadWithUrl:(NSString *)url;

// 根据URL找到一个下载类
- (Download *)findDownloadWithURL:(NSString *)url;

// 返回所有的下载类
- (NSArray *)allDownlod;

@end
