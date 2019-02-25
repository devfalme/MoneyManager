//
//  MM_BankResultModel.h
//  Calculator
//
//  Created by devfalme on 2018/12/13.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

#ifndef BankResultModel
#define BankResultModel MM_BankResultModel
#endif


@interface MM_BankResultModel : MM_BaseModel

@property (nonatomic, retain) NSNumber *rateMoney;
@property (nonatomic, retain) NSNumber *totalMoney;

@end

NS_ASSUME_NONNULL_END
