//
//  FMDatabaseQueue+Extension.m
//  ZhihuDailyMVVM
//
//  Created by xayoung on 16/10/23.
//  Copyright © 2016年 xayoung. All rights reserved.
//

#import "FMDatabaseQueue+Extension.h"
#import "define.h"

#define DB_PATH [NSString stringWithFormat:@"%@/%@.db", ST_DOCUMENT_DIRECTORY, ST_APP_NAME]

@implementation FMDatabaseQueue (Extension)
+ (instancetype)shareInstense{
    static FMDatabaseQueue *queue = nil;

    static dispatch_once_t onceTOken;

    dispatch_once(&onceTOken, ^{
        // 根据路径，创建数据库
        queue = [FMDatabaseQueue databaseQueueWithPath:DB_PATH];
    });

    return queue;

}
@end
