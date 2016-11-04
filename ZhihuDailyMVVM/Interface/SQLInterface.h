//
//  SQLInterface.h
//  ZhihuDailyMVVM
//
//  Created by xayoung on 16/10/23.
//  Copyright © 2016年 xayoung. All rights reserved.
//

#import <Foundation/Foundation.h>

// 数据缓存统一接口，在需要存储数据的类中遵循协议
@protocol SQLInterface <NSObject>

@optional
- (BOOL)saveData;
- (void)loadData;
- (BOOL)deleteData;
- (BOOL)updateData;

@end
