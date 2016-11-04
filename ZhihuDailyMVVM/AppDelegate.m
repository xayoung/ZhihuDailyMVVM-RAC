//
//  AppDelegate.m
//  ZhihuDailyMVVM
//
//  Created by xayoung on 16/10/23.
//  Copyright © 2016年 xayoung. All rights reserved.
//

#import "AppDelegate.h"
#import "FMDatabaseQueue+Extension.h"
#import "SQL.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configFMDBtables];
    return YES;
}

//创建需要的表
- (void)configFMDBtables {
    [[FMDatabaseQueue shareInstense]inDatabase:^(FMDatabase *db) {
        [db executeUpdate:createNewsSQL];
    }];
}

@end
