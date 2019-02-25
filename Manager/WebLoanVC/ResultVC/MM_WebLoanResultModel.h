//
//  MM_WebLoanResultModel.h
//  Calculator
//
//  Created by devfalme on 2018/12/13.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

#ifndef WebLoanResultModel
#define WebLoanResultModel MM_WebLoanResultModel
#endif

@interface MM_WebLoanResultModel : MM_BaseModel

@property (nonatomic, retain) NSNumber *monthMoney;
@property (nonatomic, retain) NSNumber *rateMoney;
@property (nonatomic, retain) NSNumber *totalMoney;

@end

NS_ASSUME_NONNULL_END
