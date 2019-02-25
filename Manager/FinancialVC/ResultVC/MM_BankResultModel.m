//
//  MM_BankResultModel.m
//  Calculator
//
//  Created by devfalme on 2018/12/13.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_BankResultModel.h"

@implementation MM_BankResultModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"rateMoney":@"lx",
             @"totalMoney":@"blx",
             };
}

@end
