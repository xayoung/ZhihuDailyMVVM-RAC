//
//  HomePageCell.m
//  ZhihuDailyMVVM
//
//  Created by xayoung on 16/10/25.
//  Copyright © 2016年 xayoung. All rights reserved.
//

#import "HomePageCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <YYWebImage/YYWebImage.h>

@interface HomePageCell()

@property (nonatomic, strong) UILabel *newsTitle;
@property (nonatomic, strong) UIImageView *newsImageView;

@end

@implementation HomePageCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
        [self setupSignal];
    }
    return self;
}

- (void)setupView {
    UIImageView *imageView = [UIImageView new];
    self.newsImageView = imageView;
    [self addSubview:imageView];
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.width.equalTo(@70);
        make.height.equalTo(@60);
    }];


    UILabel *newsTitle = [[UILabel alloc]init];
    newsTitle.numberOfLines = 2;
    newsTitle.font = [UIFont systemFontOfSize:14];
    self.newsTitle = newsTitle;
    [self.contentView addSubview:newsTitle];
    [newsTitle makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
        make.right.equalTo(imageView.mas_left).with.offset(-8);
    }];

}


// 设置信号量，当cell的vm被重新赋值时，更新cell显示的数据
- (void)setupSignal {

    @weakify(self);
    [RACObserve(self, viewModel) subscribeNext:^(HomePageCellViewModel *viewModel) {

        // 使用strong修饰self，防止在self在使用中被释放
        @strongify(self);

        // vm已经将要显示的文本处理好了，在cell中直接赋值就行
        
        self.newsTitle.text = viewModel.newsTitle;
        [self.newsImageView yy_setImageWithURL:[NSURL URLWithString:viewModel.imageURL] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
//        self.detailTextLabel.text = viewModel.newsId;
    }];
}

@end
