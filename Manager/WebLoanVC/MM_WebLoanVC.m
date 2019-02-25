//
//  MM_WebLoanVC.m
//  Calculator
//
//  Created by devfalme on 2018/12/13.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_WebLoanVC.h"
#import "MM_SwithCell.h"
#import "MM_NormalCell.h"
#import "MM_ConfromCell.h"
#import "MM_WebLoanModel.h"
#import "MM_WebLoanResultModel.h"
@interface MM_WebLoanVC ()
@property (nonatomic, retain) WebLoanModel *model;
@end

@implementation MM_WebLoanVC

ROUTER_PATH(@"WebLoanVC")

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.bounces = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"MM_SwithCell" bundle:nil] forCellReuseIdentifier:@"MM_SwithCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MM_NormalCell" bundle:nil] forCellReuseIdentifier:@"MM_NormalCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MM_ConfromCell" bundle:nil] forCellReuseIdentifier:@"MM_ConfromCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        return 128.0;
    }else{
        return 58.0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QMUITableViewCell *cell;
    if (indexPath.row == 3) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"MM_ConfromCell"];
    }else if (indexPath.row == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:@"MM_SwithCell"];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"MM_NormalCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell updateCellAppearanceWithIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [(NormalCell *)cell title:@"分期金额" value:[NSString stringWithFormat:@"%@元", self.model.money]];
    }else if (indexPath.row == 1){
        [(NormalCell *)cell title:@"分期期数" value:[NSString stringWithFormat:@"%@月", self.model.time]];
    }else if (indexPath.row == 2){
        [(SwithCell *)cell title:@"分期利率" leftTitle:@"月" left:^{
            self.model.timeType = TimeTypeMonth;
        } rightTitle:@"日" right:^{
            self.model.timeType = TimeTypeDay;
        } value:[NSString stringWithFormat:@"%@%%", self.model.rate] isLeft:self.model.timeType == TimeTypeMonth];
    }else {
        [(ConfromCell *)cell confirm:^{
            NSDictionary *parameter = @{
                                        @"money":self.model.money,
                                        @"time":self.model.time,
                                        @"lilv":self.model.rate,
                                        @"lilvtype":self.model.timeType == TimeTypeDay?@"2":@"1",
                                        };
            self.showLoading(@"计算中...");
            post(api(@"home/five/webloan"), parameter, ^(id obj) {
                self.hideHud();
                WebLoanResultModel *model = [[WebLoanResultModel alloc]initWithDict:obj[@"data"]];
                [Router post:ROUTER_API(@"WebLoanResultVC") parameters:@{@"model":model,@"hidesBottomBarWhenPushed":@1} type:RouterTypePush];
            }, ^(NSString *msg) {
                self.showError(msg);
            });
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NSDictionary *parameter = @{
                                    @"hidesBottomBarWhenPushed":@1,
                                    @"title":@"分期金额",
                                    @"placehold":[NSString stringWithFormat:@"%@万", self.model.money],
                                    @"type":@(UIKeyboardTypeDecimalPad),
                                    @"confirmAction":^(NSString *obj) {
                                        self.model.money = @([obj doubleValue]);
                                        [self.tableView reloadData];
                                    }
                                    };
        [Router post:ROUTER_API(@"TextFieldVC") parameters:parameter type:RouterTypePush];
    }else if (indexPath.row == 1){
        NSDictionary *parameter = @{
                                    @"hidesBottomBarWhenPushed":@1,
                                    @"title":@"分期期数",
                                    @"placehold":[NSString stringWithFormat:@"%@月", self.model.time],
                                    @"type":@(UIKeyboardTypeNumberPad),
                                    @"confirmAction":^(NSString *obj) {
                                        self.model.time = @([obj doubleValue]);
                                        [self.tableView reloadData];
                                    }
                                    };
        [Router post:ROUTER_API(@"TextFieldVC") parameters:parameter type:RouterTypePush];
    }else if (indexPath.row == 2){
        NSDictionary *parameter = @{
                                    @"hidesBottomBarWhenPushed":@1,
                                    @"title":@"分期利率",
                                    @"placehold":[NSString stringWithFormat:@"%@%%%@", self.model.rate, self.model.timeType == TimeTypeMonth?@"月":@"日"],
                                    @"type":@(UIKeyboardTypeNumberPad),
                                    @"confirmAction":^(NSString *obj) {
                                        self.model.rate = @([obj doubleValue]);
                                        [self.tableView reloadData];
                                    }
                                    };
        [Router post:ROUTER_API(@"TextFieldVC") parameters:parameter type:RouterTypePush];
    }
    
}

- (MM_WebLoanModel *)model {
    if (!_model) {
        self.model = [[WebLoanModel alloc]init];
    }
    return _model;
}
@end
