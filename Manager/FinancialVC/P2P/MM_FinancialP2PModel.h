//
//  MM_FinancialP2PModel.h
//  Calculator
//
//  Created by devfalme on 2018/12/13.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

#ifndef FinancialP2PModel
#define FinancialP2PModel MM_FinancialP2PModel
#endif

@interface MM_FinancialP2PModel : MM_BaseModel
@property (nonatomic, retain) NSNumber *savingMoney;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, retain) NSNumber *time;
@property (nonatomic, assign) TimeType timeType;
@property (nonatomic, retain) NSNumber *rate;
@property (nonatomic, assign) RateType rateType;
@property (nonatomic, assign) BOOL is360;
@property (nonatomic, assign) PayBackType payBackType;
@property (nonatomic, retain) NSNumber *manageMoney;

@end

NS_ASSUME_NONNULL_END
