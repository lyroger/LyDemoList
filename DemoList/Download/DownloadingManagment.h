//
//  DownloadingManagment.h
//  Download
//
//  Created by 陈伟捷 on 15/11/12.
//  Copyright © 2015年 chenweijie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadingManagment : NSObject

@property(nonatomic, copy)NSString *resumeDataStr;

@property(nonatomic, copy)NSString *fileSize;

@property(nonatomic, copy)NSString *filePath;

@property(nonatomic, assign)float progress;

@property(nonatomic, copy)NSString *url;

@property(nonatomic, assign)double time;

@end
