//
//  HomePageHeader.m
//  ZhihuDailyMVVM
//
//  Created by xayoung on 16/10/26.
//  Copyright © 2016年 xayoung. All rights reserved.
//

#import "HomePageHeader.h"

@implementation HomePageHeader


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.contentView.backgroundColor = [UIColor blueColor];
    UILabel *dateTitle = [UILabel new];
    dateTitle.textAlignment = NSTextAlignmentCenter;
    self.dateTitle = dateTitle;
    [self addSubview:dateTitle];
    [dateTitle makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];

}

@end
