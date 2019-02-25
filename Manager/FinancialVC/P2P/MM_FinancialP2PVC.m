//
//  MM_FinancialP2PVC.m
//  Calculator
//
//  Created by devfalme on 2018/12/13.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_FinancialP2PVC.h"
#import "MM_SwithCell.h"
#import "MM_NormalCell.h"
#import "MM_ConfromCell.h"
#import "MM_FinancialP2PModel.h"
#import "ChooseDatePickerView.h"

@interface MM_FinancialP2PVC () <ChooseDatePickerViewDelegate>
@property (nonatomic, retain) FinancialP2PModel *model;
@end

@implementation MM_FinancialP2PVC

ROUTER_PATH(@"FinancialP2PVC")

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.bounces = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"MM_NormalCell" bundle:nil] forCellReuseIdentifier:@"MM_NormalCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MM_ConfromCell" bundle:nil] forCellReuseIdentifier:@"MM_ConfromCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MM_SwithCell" bundle:nil] forCellReuseIdentifier:@"MM_SwithCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 7) {
        return 128.0;
    }else{
        return 58.0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QMUITableViewCell *cell;
    if (indexPath.row == 7) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"MM_ConfromCell"];
    }else if (indexPath.row == 2 || indexPath.row == 3){
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
        [(NormalCell *)cell title:@"理財金額" value:[NSString stringWithFormat:@"%@元", self.model.savingMoney]];
    }else if (indexPath.row == 1){
        [(NormalCell *)cell title:@"起息日期" value:self.model.startTime];
    }else if (indexPath.row == 2){
        [(SwithCell *)cell title:@"存款時長" leftTitle:@"月" left:^{
            self.model.timeType = TimeTypeMonth;
        } rightTitle:@"日" right:^{
            self.model.timeType = TimeTypeDay;
        } value:[NSString stringWithFormat:@"%@%%", self.model.time] isLeft:self.model.timeType == TimeTypeMonth];
    }else if (indexPath.row == 3){
        [(SwithCell *)cell title:@"利率" leftTitle:@"年" left:^{
            self.model.rateType = RateTypeYear;
        } rightTitle:@"日" right:^{
            self.model.rateType = RateTypeDay;
        } value:[NSString stringWithFormat:@"%@%%", self.model.rate] isLeft:self.model.rateType == RateTypeYear];
    }else if (indexPath.row == 4){
        [(NormalCell *)cell title:@"360天制" value:self.model.is360?@"是":@"否"];
    }else if (indexPath.row == 5) {
        [(NormalCell *)cell title:@"返款方式" value:convertPayBack(self.model.payBackType)];
    }else if (indexPath.row == 6) {
        [(NormalCell *)cell title:@"管理費" value:[NSString stringWithFormat:@"%@%%", self.model.manageMoney]];
    }else {
        //        [(ConfromCell *)cell confirm:^{
        //            NSDictionary *parameter = @{
        //                                        @"type":@"3",
        //                                        @"huankuantype":@(self.model.method),
        //                                        @"shangyemoney":self.model.businessMoney,
        //                                        @"gongjijinmoney":self.model.fundMoney,
        //                                        @"time":self.model.years,
        //                                        @"banklv":self.model.businessRate,
        //                                        @"gongjijinlv":self.model.fundRate,
        //                                        };
        //            self.showLoading(@"计算中...");
        //            post(api(@"home/five/loan"), parameter, ^(id obj) {
        //                self.hideHud();
        //                HouseLoanResultModel *model = [[HouseLoanResultModel alloc]initWithDictionary:obj[@"data"]];
        //                [Router post:ROUTER_API(@"HouseLoanResultVC") parameters:@{@"model":model,@"hidesBottomBarWhenPushed":@1} fail:nil];
        //            }, ^(NSString *msg) {
        //                self.showError(msg);
        //            });
        //        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NSDictionary *parameter = @{
                                    @"hidesBottomBarWhenPushed":@1,
                                    @"title":@"理財金額",
                                    @"placehold":[NSString stringWithFormat:@"%@元", self.model.savingMoney],
                                    @"type":@(UIKeyboardTypeDecimalPad),
                                    @"confirmAction":^(NSString *obj) {
                                        self.model.savingMoney = @([obj doubleValue]);
                                        [self.tableView reloadData];
                                    }
                                    };
        [Router post:ROUTER_API(@"TextFieldVC") parameters:parameter type:RouterTypePush];
    }else if (indexPath.row == 1){
        ChooseDatePickerView *chooseDataPicker = [[ChooseDatePickerView alloc] initWithFrame:self.view.bounds];
        chooseDataPicker.delegate = self;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [dateFormatter dateFromString:self.model.startTime];
        chooseDataPicker.data = date;
        [chooseDataPicker show];
    }else if (indexPath.row == 2){
        NSDictionary *parameter = @{
                                    @"hidesBottomBarWhenPushed":@1,
                                    @"title":@"存款时长",
                                    @"placehold":[NSString stringWithFormat:@"%@%@", self.model.time, self.model.timeType == TimeTypeMonth?@"月":@"日"],
                                    @"type":@(UIKeyboardTypeNumberPad),
                                    @"confirmAction":^(NSString *obj) {
                                        self.model.time = @([obj doubleValue]);
                                        [self.tableView reloadData];
                                    }
                                    };
        [Router post:ROUTER_API(@"TextFieldVC") parameters:parameter type:RouterTypePush];
    }else if (indexPath.row == 3){
        NSDictionary *parameter = @{
                                    @"hidesBottomBarWhenPushed":@1,
                                    @"title":@"利率",
                                    @"placehold":[NSString stringWithFormat:@"%@%%%@", self.model.rate, self.model.rateType == RateTypeYear?@"年":@"日"],
                                    @"type":@(UIKeyboardTypeDecimalPad),
                                    @"confirmAction":^(NSString *obj) {
                                        self.model.rate = @([obj doubleValue]);
                                        [self.tableView reloadData];
                                    }
                                    };
        [Router post:ROUTER_API(@"TextFieldVC") parameters:parameter type:RouterTypePush];
    }else if (indexPath.row == 4) {
        QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
        }];
        QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"是" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
            self.model.is360 = YES;
            [self.tableView reloadData];
        }];
        QMUIAlertAction *action3 = [QMUIAlertAction actionWithTitle:@"否" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
            self.model.is360 = NO;
            [self.tableView reloadData];
        }];
        QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"360天制" message:nil preferredStyle:QMUIAlertControllerStyleActionSheet];
        [alertController addAction:action1];
        [alertController addAction:action2];
        [alertController addAction:action3];
        
        QMUIVisualEffectView *visualEffectView = [[QMUIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        visualEffectView.foregroundColor = UIColorMakeWithRGBA(255, 255, 255, .6);// 一般用默认值就行，不用主动去改，这里只是为了展示用法
        alertController.mainVisualEffectView = visualEffectView;// 这个负责上半部分的磨砂
        
        visualEffectView = [[QMUIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        visualEffectView.foregroundColor = UIColorMakeWithRGBA(255, 255, 255, .6);// 一般用默认值就行，不用主动去改，这里只是为了展示用法
        alertController.cancelButtonVisualEffectView = visualEffectView;// 这个负责取消按钮的磨砂
        alertController.sheetHeaderBackgroundColor = nil;
        alertController.sheetButtonBackgroundColor = nil;
        [alertController showWithAnimated:YES];
    }else if (indexPath.row == 5) {
        QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
        }];
        QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"按月付息到期还本" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
            self.model.payBackType = PayBackTypeOne;
            [self.tableView reloadData];
        }];
        QMUIAlertAction *action3 = [QMUIAlertAction actionWithTitle:@"一次性还本付息" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
            self.model.payBackType = PayBackTypeTwo;
            [self.tableView reloadData];
        }];
        QMUIAlertAction *action4 = [QMUIAlertAction actionWithTitle:@"等额本息" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
            self.model.payBackType = PayBackTypeThree;
            [self.tableView reloadData];
        }];
        QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"返款方式" message:nil preferredStyle:QMUIAlertControllerStyleActionSheet];
        [alertController addAction:action1];
        [alertController addAction:action2];
        [alertController addAction:action3];
        [alertController addAction:action4];
        
        QMUIVisualEffectView *visualEffectView = [[QMUIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        visualEffectView.foregroundColor = UIColorMakeWithRGBA(255, 255, 255, .6);// 一般用默认值就行，不用主动去改，这里只是为了展示用法
        alertController.mainVisualEffectView = visualEffectView;// 这个负责上半部分的磨砂
        
        visualEffectView = [[QMUIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        visualEffectView.foregroundColor = UIColorMakeWithRGBA(255, 255, 255, .6);// 一般用默认值就行，不用主动去改，这里只是为了展示用法
        alertController.cancelButtonVisualEffectView = visualEffectView;// 这个负责取消按钮的磨砂
        alertController.sheetHeaderBackgroundColor = nil;
        alertController.sheetButtonBackgroundColor = nil;
        [alertController showWithAnimated:YES];
    }else if (indexPath.row == 6) {
        NSDictionary *parameter = @{
                                    @"hidesBottomBarWhenPushed":@1,
                                    @"title":@"管理费",
                                    @"placehold":[NSString stringWithFormat:@"%@%%", self.model.manageMoney],
                                    @"type":@(UIKeyboardTypeDecimalPad),
                                    @"confirmAction":^(NSString *obj) {
                                        self.model.manageMoney = @([obj doubleValue]);
                                        [self.tableView reloadData];
                                    }
                                    };
        [Router post:ROUTER_API(@"TextFieldVC") parameters:parameter type:RouterTypePush];
    }
    
}

- (MM_FinancialP2PModel *)model {
    if (!_model) {
        self.model = [[FinancialP2PModel alloc]init];
    }
    return _model;
}

- (void)finishSelectDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.model.startTime = [formatter stringFromDate:date];
}
@end
