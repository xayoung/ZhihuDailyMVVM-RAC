//
//  HomePageViewModel.h
//  ZhihuDailyMVVM
//
//  Created by xayoung on 16/10/23.
//  Copyright © 2016年 xayoung. All rights reserved.
//

#import "RequestViewModel.h"
#import "SQLInterface.h"
#import "NewsModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>


// vc的vm
// 因为需要进行数据缓存，所以遵循SQLInterface
// 因为需要进行网络请求，所以继承自RequestViewModel
@interface HomePageViewModel : RequestViewModel <SQLInterface>

@property (nonatomic, strong) RACSignal *requestSignal; ///< 网络请求信号量
@property (strong, nonatomic) NSString *currentDate; ///< 当前页码
@property (strong, nonatomic) NSArray *dataSource; ///< tableView的数据源
@property (strong, nonatomic) NSArray *headDataSource; ///< tableView的数据源

@end
