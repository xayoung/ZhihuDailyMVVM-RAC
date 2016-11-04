//
//  SQL.h
//  ZhihuDailyMVVM
//
//  Created by xayoung on 16/10/23.
//  Copyright © 2016年 xayoung. All rights reserved.
//

#import <Foundation/Foundation.h>

// 项目中执行的SQL

static NSString * const createNewsSQL = @"CREATE TABLE IF NOT EXISTS news (id INT, title VARCHAR, image VARCHAR, date VARCHAR)";

static NSString * const saveNewsSQL = @"INSERT INTO news VALUES (?, ?, ?, ?)";
static NSString * const deleteNewsSQL = @"DELETE FROM news";
static NSString * const selectNewsSQL = @"SELECT * FROM news";
