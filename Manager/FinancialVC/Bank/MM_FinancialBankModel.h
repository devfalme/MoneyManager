//
//  MM_FinancialBankModel.h
//  Calculator
//
//  Created by devfalme on 2018/12/13.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

#ifndef FinancialBankModel
#define FinancialBankModel MM_FinancialBankModel
#endif

@interface MM_FinancialBankModel : MM_BaseModel

@property (nonatomic, retain) NSNumber *savingMoney;
@property (nonatomic, assign) SavingType type;
@property (nonatomic, assign) SavingTime time;
@property (nonatomic, retain) NSNumber *rate;


@end

NS_ASSUME_NONNULL_END
