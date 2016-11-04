//
//  HomePageCellViewModel.m
//  ZhihuDailyMVVM
//
//  Created by xayoung on 16/10/24.
//  Copyright © 2016年 xayoung. All rights reserved.
//

#import "HomePageCellViewModel.h"

@implementation HomePageCellViewModel

- (instancetype)initWithNewsModel:(NewsModel *)newsModel{
    self = [super init];

    if (self) {
        self.newsModel = newsModel;
        [self setupData];
    }
    return self;
}


// 处理Model中的数据
- (void)setupData {
    _newsTitle = self.newsModel.title;
    _newsId = self.newsModel.newsid;
    _imageURL = self.newsModel.image;
}

@end
