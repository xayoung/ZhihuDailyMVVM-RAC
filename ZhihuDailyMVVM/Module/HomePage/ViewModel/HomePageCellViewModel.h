//
//  HomePageCellViewModel.h
//  ZhihuDailyMVVM
//
//  Created by xayoung on 16/10/24.
//  Copyright © 2016年 xayoung. All rights reserved.
//

#import "BaseViewModel.h"
#import "NewsModel.h"

// cell的vm
// 无需网络请求，所以继承BaseViewModel即可
@interface HomePageCellViewModel : BaseViewModel

@property (nonatomic, strong) NewsModel *newsModel;

@property (nonatomic, copy, readonly) NSString *newsTitle;
@property (nonatomic, copy, readonly) NSString *newsId;
@property (nonatomic, copy, readonly) NSString *imageURL;

- (instancetype)initWithNewsModel:(NewsModel *)newsModel;

@end
