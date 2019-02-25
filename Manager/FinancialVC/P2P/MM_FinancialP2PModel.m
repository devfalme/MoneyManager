
//
//  MM_FinancialP2PModel.m
//  Calculator
//
//  Created by devfalme on 2018/12/13.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_FinancialP2PModel.h"

@implementation MM_FinancialP2PModel

- (instancetype)init {
    if (self = [super init]) {
        self.savingMoney = @100;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        self.startTime = [formatter stringFromDate:[NSDate date]];
        self.time = @5;
        self.timeType = TimeTypeMonth;
        self.rate = @5;
        self.rateType = RateTypeYear;
        self.is360 = YES;
        self.payBackType = PayBackTypeOne;
        self.manageMoney = @1;
    }return self;
}


@end
