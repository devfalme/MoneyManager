//
//  MM_WebLoanModel.h
//  Calculator
//
//  Created by devfalme on 2018/12/13.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_BaseModel.h"

NS_ASSUME_NONNULL_BEGIN
#ifndef WebLoanModel
#define WebLoanModel MM_WebLoanModel
#endif

@interface MM_WebLoanModel : MM_BaseModel
@property (nonatomic, retain) NSNumber *money;
@property (nonatomic, retain) NSNumber *time;
@property (nonatomic, retain) NSNumber *rate;
@property (nonatomic, assign) TimeType timeType;
@end

NS_ASSUME_NONNULL_END
