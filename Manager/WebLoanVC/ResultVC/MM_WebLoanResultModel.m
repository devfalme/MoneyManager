//
//  MM_WebLoanResultModel.m
//  Calculator
//
//  Created by devfalme on 2018/12/13.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_WebLoanResultModel.h"

@implementation MM_WebLoanResultModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"monthMoney":@"yuegong",
             @"rateMoney":@"lx",
             @"totalMoney":@"zong"
             };
}

@end
