//
//  MM_FinancialVC.m
//  Calculator
//
//  Created by devfalme on 2018/12/12.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_FinancialVC.h"
#import "MM_FinancialMenuView.h"

@interface MM_FinancialVC ()

@property (nonatomic, retain) FinancialMenuView *menu;

@property (nonatomic, retain) UIViewController *bankVC;
@property (nonatomic, retain) UIViewController *p2pVC;

@property (nonatomic, retain) UIViewController *currentVC;

@end

@implementation MM_FinancialVC

ROUTER_PATH(@"FinancialVC")

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.menu = [FinancialMenuView bank:^{
//        [self turnTo:self.bankVC];
//    } p2p:^{
//        [self turnTo:self.p2pVC];
//    }];
//
//    [self.view addSubview:self.menu];
//    [self.menu mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(self.view);
//        make.height.mas_equalTo(58.0);
//    }];
    
    [self turnTo:self.bankVC];
}

- (void)turnTo:(UIViewController *)vc {
    if (self.currentVC) {
        [self.currentVC.view removeFromSuperview];
    }
    self.currentVC = vc;
    [self.view addSubview:self.currentVC.view];
    [self.currentVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.menu.mas_bottom);
        make.top.equalTo(self.view);
        make.bottom.left.right.equalTo(self.view);
    }];
}

- (UIViewController *)bankVC {
    if (!_bankVC) {
        self.bankVC = [Router search:ROUTER_API(@"FinancialBankVC") parameters:@{}];
        [self addChildViewController:_bankVC];
    }return _bankVC;
}

- (UIViewController *)p2pVC {
    if (!_p2pVC) {
        self.p2pVC = [Router search:ROUTER_API(@"FinancialP2PVC") parameters:@{}];
        [self addChildViewController:_p2pVC];
    }return _p2pVC;
}



@end
