//
//  RequestViewModel.m
//  ZhihuDailyMVVM
//
//  Created by xayoung on 16/10/23.
//  Copyright © 2016年 xayoung. All rights reserved.
//

#import "RequestViewModel.h"

@implementation RequestViewModel

//懒加载
- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
    }
    return _sessionManager;
}

//对象销毁的时候，取消已经在队列中的请求
- (void)dealloc {
    [self.sessionManager invalidateSessionCancelingTasks:YES];
}


@end
