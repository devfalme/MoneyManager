//
//  MM_WebLoanModel.m
//  Calculator
//
//  Created by devfalme on 2018/12/13.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_WebLoanModel.h"

@implementation MM_WebLoanModel


- (instancetype)init {
    if (self = [super init]) {
        self.money = @100;
        self.time = @12;
        self.rate = @0.45;
        self.timeType = TimeTypeMonth;
    }return self;
}

@end
