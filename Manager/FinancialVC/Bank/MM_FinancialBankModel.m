//
//  MM_FinancialBankModel.m
//  Calculator
//
//  Created by devfalme on 2018/12/13.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_FinancialBankModel.h"

@implementation MM_FinancialBankModel

- (instancetype)init {
    if (self = [super init]) {
        _savingMoney = @100;
        _type = SavingTypeCurrent;
        _time = SavingTimeOne;
        _rate = @0.35;
    }return self;
}

- (void)setType:(SavingType)type {
    _type = type;
    if (_type == SavingTypeCurrent) {
        _rate = @0.35;
    }else{
        if (_time == SavingTimeOne) {
            _rate = @1.10;
        }else if (_time == SavingTimeTwo) {
            _rate = @1.30;
        }else if (_time == SavingTimeThree) {
            _rate = @1.50;
        }else if (_time == SavingTimeFour) {
            _rate = @2.10;
        }else if (_time == SavingTimeFive) {
            _rate = @2.75;
        }else if (_time == SavingTimeSix) {
            _rate = @2.75;
        }
    }
}

- (void)setTime:(SavingTime)time {
    _time = time;
    if (_type == SavingTypeCurrent) {
        _rate = @0.35;
    }else{
        if (_time == SavingTimeOne) {
            _rate = @1.10;
        }else if (_time == SavingTimeTwo) {
            _rate = @1.30;
        }else if (_time == SavingTimeThree) {
            _rate = @1.50;
        }else if (_time == SavingTimeFour) {
            _rate = @2.10;
        }else if (_time == SavingTimeFive) {
            _rate = @2.75;
        }else if (_time == SavingTimeSix) {
            _rate = @2.75;
        }
    }
}

@end
