//
//  HomePageViewModel.m
//  ZhihuDailyMVVM
//
//  Created by xayoung on 16/10/23.
//  Copyright © 2016年 xayoung. All rights reserved.
//

#import "HomePageViewModel.h"
#import "HomePageCellViewModel.h"
#import "FMDatabaseQueue+Extension.h"
#import "SQL.h"
#import <YYModel/YYModel.h>


@interface HomePageViewModel()

@property (nonatomic, strong) NSMutableArray *newsViewModels;   ///< 这个属性主要存储的是消息的vm，上拉加载的时候追加，下拉刷新的时候清空。防止直接修改dataSource
@property (nonatomic, strong) NSMutableArray *headDates;

@property (nonatomic, assign) BOOL isRefresh;   ///< 是否是刷新(用于处理数据缓存与dataSource)

@end

@implementation HomePageViewModel

- (NSMutableArray *)newsViewModels {

    if (!_newsViewModels) {
        _newsViewModels = [NSMutableArray new];
    }
    return _newsViewModels;
}

- (NSMutableArray *)headDates {

    if (!_headDates) {
        _headDates = [NSMutableArray new];
    }
    return _headDates;
}

#pragma mark - SQLInterface

- (BOOL)saveData{
    __block BOOL isSuccess = NO;

    [[FMDatabaseQueue shareInstense]inTransaction:^(FMDatabase *db, BOOL *rollback) {

    }];

    return isSuccess;
}

#pragma mark - Getter / Setter

//采用懒加载的方式来配置网络请求
- (RACSignal *)requestSignal{

    
    if (!_requestSignal) {

        @weakify(self);

        _requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {

            @strongify(self);

            NSString *date = [self.currentDate isEqualToString:@"latest"] ? @"latest" : [NSString stringWithFormat:@"before/%@",self.currentDate];

            NSLog(@"进行请求%@",self.currentDate);
            NSString *url = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/news/%@",date];
            
            NSURLSessionDataTask *task = [self.sessionManager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

                NSLog(@"网络请求成功:%@",responseObject[@"date"]);

                if ([self.currentDate isEqualToString:@"latest"]) {
                    [self.newsViewModels removeAllObjects];
                    [self.headDates removeAllObjects];
                }


                [self.headDates addObject:responseObject[@"date"]];
                self.headDataSource = [self.headDates copy];
                NSArray *stories = responseObject[@"stories"];
                NSMutableArray *sectionArray = [NSMutableArray new];
                for (NSDictionary *item in stories) {
                    NewsModel *newsModel = [NewsModel yy_modelWithDictionary:item];
                    newsModel.image = newsModel.images[0];
                    HomePageCellViewModel *cellViewModel = [[HomePageCellViewModel alloc]initWithNewsModel:newsModel];
                    [sectionArray addObject:cellViewModel];
                }

                [self.newsViewModels addObject:sectionArray];
                self.dataSource = [self.newsViewModels copy];

                [subscriber sendNext:self.dataSource];
                [subscriber sendCompleted];

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [subscriber sendError:error];
            }];

            @synchronized (task) {

            }

            // 在信号量作废时，取消网络请求
            return [RACDisposable disposableWithBlock:^{

                [task cancel];
            }];


        }];
    }
    return _requestSignal;
}


@end
