//
//  NewsModel.m
//  ZhihuDailyMVVM
//
//  Created by xayoung on 16/10/23.
//  Copyright © 2016年 xayoung. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"newsid" : @"id"};
}
@end
