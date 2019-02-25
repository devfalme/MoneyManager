//
//  UIViewController+MM_Manager.h
//  Manager
//
//  Created by devfalme on 2018/12/19.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (MM_Manager)
@property (nonatomic, readonly, copy) void(^rightBarItem)(UIView *);

@property (nonatomic, copy, readonly) void(^vcTitle)(NSString *title);

@property (nonatomic, readonly, copy) void(^showLoading)(NSString *msg);
@property (nonatomic, readonly, copy) void(^showText)(NSString *msg);
@property (nonatomic, readonly, copy) void(^hideHud)(void);
@property (nonatomic, readonly, copy) void(^hideHudWhen)(NSInteger time);
@property (nonatomic, readonly, copy) void(^showError)(NSString *msg);
@property (nonatomic, readonly, copy) void(^showSuccess)(NSString *msg);

@property (nonatomic, copy, readonly) void (^vcPush)(UIViewController *);
@property (nonatomic, copy, readonly) void (^vcPop)(void);
@property (nonatomic, copy, readonly) void (^vcAddChildVC)(UIViewController *);

- (void)restoreRootViewController:(UIViewController *)rootViewController completion:(void (^__nullable)(BOOL finished))completion;
@end

NS_ASSUME_NONNULL_END
