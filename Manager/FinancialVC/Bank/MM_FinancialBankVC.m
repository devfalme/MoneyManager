//
//  MM_FinancialBankVC.m
//  Calculator
//
//  Created by devfalme on 2018/12/13.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_FinancialBankVC.h"
#import "MM_FinancialBankModel.h"
#import "MM_NormalCell.h"
#import "MM_ConfromCell.h"
#import "MM_BankResultModel.h"

@interface MM_FinancialBankVC ()
@property (nonatomic, retain) FinancialBankModel *model;
@end

@implementation MM_FinancialBankVC

ROUTER_PATH(@"FinancialBankVC")


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.bounces = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"MM_NormalCell" bundle:nil] forCellReuseIdentifier:@"MM_NormalCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MM_ConfromCell" bundle:nil] forCellReuseIdentifier:@"MM_ConfromCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        return 128.0;
    }else{
        return 58.0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QMUITableViewCell *cell;
    if (indexPath.row == 4) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"MM_ConfromCell"];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"MM_NormalCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell updateCellAppearanceWithIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [(NormalCell *)cell title:@"存款金額" value:[NSString stringWithFormat:@"%@元", self.model.savingMoney]];
    }else if (indexPath.row == 1){
        [(NormalCell *)cell title:@"存款類型" value:convertSavingType(self.model.type)];
    }else if (indexPath.row == 2){
        [(NormalCell *)cell title:@"存款期限" value:convertSavingTime(self.model.time)];
    }else if (indexPath.row == 3){
        [(NormalCell *)cell title:@"年利率" value:[NSString stringWithFormat:@"%@%%", self.model.rate]];
    }else {
        [(ConfromCell *)cell confirm:^{
            NSDictionary *parameter = @{
                                        @"money":self.model.savingMoney,
                                        @"type":self.model.type == SavingTypeBound?@"定期":@"活期",
                                        @"time":@(self.model.time),
                                        };
            self.showLoading(@"計算中...");
            post(api(@"home/five/financing"), parameter, ^(id obj) {
                self.hideHud();
                BankResultModel *model = [[BankResultModel alloc]initWithDict:obj[@"data"]];
                [Router post:ROUTER_API(@"BankResultVC") parameters:@{@"model":model,@"hidesBottomBarWhenPushed":@1} type:RouterTypePush];
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
                                    @"title":@"存款金額",
                                    @"placehold":[NSString stringWithFormat:@"%@元", self.model.savingMoney],
                                    @"type":@(UIKeyboardTypeDecimalPad),
                                    @"confirmAction":^(NSString *obj) {
                                        self.model.savingMoney = @([obj doubleValue]);
                                        [self.tableView reloadData];
                                    }
                                    };
        [Router post:ROUTER_API(@"TextFieldVC") parameters:parameter type:RouterTypePush];
    }else if (indexPath.row == 1){
        QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
        }];
        QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"定期" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
            self.model.type = SavingTypeBound;
            [self.tableView reloadData];
        }];
        QMUIAlertAction *action3 = [QMUIAlertAction actionWithTitle:@"活期" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
            self.model.type = SavingTypeCurrent;
            [self.tableView reloadData];
        }];
        QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"存款类型" message:nil preferredStyle:QMUIAlertControllerStyleActionSheet];
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
    }else if (indexPath.row == 2){
        QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
        }];
        QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"3个月" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
            self.model.time = SavingTimeOne;
            [self.tableView reloadData];
        }];
        QMUIAlertAction *action3 = [QMUIAlertAction actionWithTitle:@"6个月" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
            self.model.time = SavingTimeTwo;
            [self.tableView reloadData];
        }];
        QMUIAlertAction *action4 = [QMUIAlertAction actionWithTitle:@"1年" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
            self.model.time = SavingTimeThree;
            [self.tableView reloadData];
        }];
        QMUIAlertAction *action5 = [QMUIAlertAction actionWithTitle:@"2年" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
            self.model.time = SavingTimeFour;
            [self.tableView reloadData];
        }];
        QMUIAlertAction *action6 = [QMUIAlertAction actionWithTitle:@"3年" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
            self.model.time = SavingTimeFive;
            [self.tableView reloadData];
        }];
        QMUIAlertAction *action7 = [QMUIAlertAction actionWithTitle:@"5年" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
            self.model.time = SavingTimeSix;
            [self.tableView reloadData];
        }];
        QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"存款类型" message:nil preferredStyle:QMUIAlertControllerStyleActionSheet];
        [alertController addAction:action1];
        [alertController addAction:action2];
        [alertController addAction:action3];
        [alertController addAction:action4];
        [alertController addAction:action5];
        [alertController addAction:action6];
        [alertController addAction:action7];
        
        QMUIVisualEffectView *visualEffectView = [[QMUIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        visualEffectView.foregroundColor = UIColorMakeWithRGBA(255, 255, 255, .6);// 一般用默认值就行，不用主动去改，这里只是为了展示用法
        alertController.mainVisualEffectView = visualEffectView;// 这个负责上半部分的磨砂
        
        visualEffectView = [[QMUIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        visualEffectView.foregroundColor = UIColorMakeWithRGBA(255, 255, 255, .6);// 一般用默认值就行，不用主动去改，这里只是为了展示用法
        alertController.cancelButtonVisualEffectView = visualEffectView;// 这个负责取消按钮的磨砂
        alertController.sheetHeaderBackgroundColor = nil;
        alertController.sheetButtonBackgroundColor = nil;
        [alertController showWithAnimated:YES];
    }else if (indexPath.row == 3){
        
    }
    
}

- (MM_FinancialBankModel *)model {
    if (!_model) {
        self.model = [[FinancialBankModel alloc]init];
    }
    return _model;
}

@end
