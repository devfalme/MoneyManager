//
//  MM_EditIncomeVC.h
//  Manager
//
//  Created by devfalme on 2018/12/19.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MM_EditIncomeVC : MM_BaseVC
- (instancetype)initWithModel:(MM_AccountCellModel *)model change:(void(^)(MM_AccountCellModel *model))change;
@end

NS_ASSUME_NONNULL_END
