//
//  NewsModel.h
//  ZhihuDailyMVVM
//
//  Created by xayoung on 16/10/23.
//  Copyright © 2016年 xayoung. All rights reserved.
//

#import "BaseModel.h"

@interface NewsModel : BaseModel

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *newsid;
@property (copy, nonatomic) NSArray *images;
@property (copy, nonatomic) NSString *image;
@end
