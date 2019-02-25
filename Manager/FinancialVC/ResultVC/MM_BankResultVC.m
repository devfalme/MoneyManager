//
//  MM_BankResultVC.m
//  Calculator
//
//  Created by devfalme on 2018/12/13.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_BankResultVC.h"
#import "MM_NormalCell.h"
#import "MM_BankResultModel.h"
@interface MM_BankResultVC ()
@property (nonatomic, retain) BankResultModel *model;
@end

@implementation MM_BankResultVC

ROUTER_PATH(@"BankResultVC")


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"计算结果";
    self.tableView.bounces = NO;
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20.0)];
    [self.tableView registerNib:[UINib nibWithNibName:@"MM_NormalCell" bundle:nil] forCellReuseIdentifier:@"MM_NormalCell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
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
        [(NormalCell *)cell title:@"利息" value:[NSString stringWithFormat:@"%@元", self.model.rateMoney]];
    }else if (indexPath.row == 1){
        [(NormalCell *)cell title:@"本息" value:[NSString stringWithFormat:@"%@元", self.model.totalMoney]];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
