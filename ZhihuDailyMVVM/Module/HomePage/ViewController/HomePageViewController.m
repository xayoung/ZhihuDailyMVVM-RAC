//
//  HomePageViewController.m
//  ZhihuDailyMVVM
//
//  Created by xayoung on 16/10/24.
//  Copyright © 2016年 xayoung. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomePageViewModel.h"
#import "HomePageCell.h"
#import "HomePageHeader.h"
#import "NSDate+Utilities_y.h"




@interface HomePageViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

//VM
@property (nonatomic, strong) HomePageViewModel *viewModel;

@end

@implementation HomePageViewController

#pragma mark - Lazy Load

- (HomePageViewModel *)viewModel {

    if (!_viewModel) {
        _viewModel = [HomePageViewModel new];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    self.viewModel.currentDate = @"latest";
    [self sendRequest];

}

- (void)viewDidAppear:(BOOL)animated {
    [self addRefresh];
}

- (void)setupView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator = NO;
    self.tableView = tableView;
    [self.view addSubview:tableView];
}



- (void)sendRequest {
    @weakify(self);
    [self.viewModel.requestSignal subscribeNext:^(NSArray *news) {
        @strongify(self);
        NSLog(@"加载成功");
        [self.tableView reloadData];
    } error:^(NSError *error) {

    }];
}

- (NSString *)subDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMdd"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    if ([self.viewModel.currentDate isEqualToString:@"latest"]) {
        NSDate *date = [NSDate new] ;
        return [formatter stringFromDate:date];
    }else{
        NSDate *date = [formatter dateFromString:self.viewModel.currentDate];
        NSDate *newDate = [date dateBySubtractingHours:24];
        return [formatter stringFromDate:newDate];
    }
}

- (void)addRefresh {
    [[[RACObserve(self.tableView, contentOffset) map:^id(NSNumber *value) {
        if (self.tableView.contentOffset.y < -50) {
            return @(1);
        } 
        if (self.tableView.contentOffset.y > self.tableView.contentSize.height - self.tableView.frame.size.height &&self.tableView.contentSize.height > 0  ) {
            return @(2);
        }else{
            return @(0);
        }
    }] distinctUntilChanged] subscribeNext:^(NSNumber *pullToRefresh) {
        NSLog(@"%@", pullToRefresh);

        switch ([pullToRefresh integerValue]) {
            case 1:
                //下拉
                self.viewModel.currentDate = @"latest";
                [self sendRequest];
                break;
            case 2:
                //上拉
                self.viewModel.currentDate = [self subDate];
                NSLog(@"%@",self.viewModel.currentDate);
                [self sendRequest];
                break;
            default:
                break;
        }

    }];
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewModel.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.viewModel.dataSource[section] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HomePageHeader *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!headerView) {
        headerView = [[HomePageHeader alloc]init];
    }

    headerView.dateTitle.text = self.viewModel.headDataSource[section];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    HomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (!cell) {
        cell = [[HomePageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    [self configCell:cell indexPath:indexPath];
    return cell;
}

- (void)configCell:(HomePageCell *)cell indexPath:(NSIndexPath *)indexPath {

    // 将数据赋值给cell的vm
    // cell接收到vm修改以后，就会触发初始时设置的信号量
    cell.viewModel = self.viewModel.dataSource[indexPath.section][indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}



@end

