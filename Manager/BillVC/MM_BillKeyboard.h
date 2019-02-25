//
//  MM_BillKeyboard.h
//  Manager
//
//  Created by devfalme on 2018/12/17.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MM_BillKeyboard : UIView

- (void)imageName:(NSString *)imageName;
- (void)date:(NSString *)date;
- (void)placehold:(NSString *)placehold;

- (void)reload;

+ (instancetype)date:(void(^)(void))date action:(void(^)(NSString *remark, NSNumber *price))action;

@end

NS_ASSUME_NONNULL_END
