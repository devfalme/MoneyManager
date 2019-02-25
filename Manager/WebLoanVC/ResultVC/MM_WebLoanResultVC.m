//
//  MM_WebLoanResultVC.m
//  Calculator
//
//  Created by devfalme on 2018/12/13.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_WebLoanResultVC.h"
#import "MM_NormalCell.h"
#import "MM_WebLoanResultModel.h"
@interface MM_WebLoanResultVC ()
@property (nonatomic, retain) WebLoanResultModel *model;
@end

@implementation MM_WebLoanResultVC

ROUTER_PATH(@"WebLoanResultVC")

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.bounces = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"MM_NormalCell" bundle:nil] forCellReuseIdentifier:@"MM_NormalCell"];
    self.title = @"计算结果";
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20.0)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 58.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MM_NormalCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell updateCellAppearanceWithIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [(NormalCell *)cell title:@"月供金额" value:[NSString stringWithFormat:@"%@元", self.model.monthMoney]];
    }else if (indexPath.row == 1){
        [(NormalCell *)cell title:@"支付利息" value:[NSString stringWithFormat:@"%@元", self.model.rateMoney]];
    }else {
        [(NormalCell *)cell title:@"还款总额" value:[NSString stringWithFormat:@"%@元", self.model.totalMoney]];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

@end
