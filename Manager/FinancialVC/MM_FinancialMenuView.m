//
//  MM_FinancialMenuView.m
//  Calculator
//
//  Created by devfalme on 2018/12/12.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_FinancialMenuView.h"
@interface MM_FinancialMenuView ()
@property (weak, nonatomic) IBOutlet UIButton *bankButton;
@property (weak, nonatomic) IBOutlet UIButton *p2pButton;

@end
@implementation MM_FinancialMenuView

+ (instancetype)bank:(void(^)(void))bank p2p:(void(^)(void))p2p {
    FinancialMenuView *menu = [FinancialMenuView loadFromNib];
    [[menu.bankButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        menu.bankButton.enabled = NO;
        menu.p2pButton.enabled = YES;
        
        menu.bankButton.backgroundColor = darkColor;
        menu.p2pButton.backgroundColor = lightColor;
        
        bank();
    }];
    
    [[menu.p2pButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        menu.p2pButton.enabled = NO;
        menu.bankButton.enabled = YES;
        
        menu.p2pButton.backgroundColor = darkColor;
        menu.bankButton.backgroundColor = lightColor;
        
        p2p();
    }];
    
    return menu;
}

@end
