//
//  MM_FinancialMenuView.h
//  Calculator
//
//  Created by devfalme on 2018/12/12.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#ifndef FinancialMenuView
#define FinancialMenuView MM_FinancialMenuView
#endif

@interface MM_FinancialMenuView : UIView

+ (instancetype)bank:(void(^)(void))bank p2p:(void(^)(void))p2p;

@end

NS_ASSUME_NONNULL_END
