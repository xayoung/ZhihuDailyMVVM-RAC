//
//  RequestViewModel.h
//  ZhihuDailyMVVM
//
//  Created by xayoung on 16/10/23.
//  Copyright © 2016年 xayoung. All rights reserved.
//

#import "BaseViewModel.h"
#import <AFNetworking/AFNetworking.h>

// 继承自BaseViewModel
// 需要网络请求的VM继承该类
// 该类有一个公共属性sessionManager，一个该属性的懒加载方法和一个dealloc中取消网络请求的方法
@interface RequestViewModel : BaseViewModel

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end
