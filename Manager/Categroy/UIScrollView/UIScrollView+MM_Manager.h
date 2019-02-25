//
//  UIScrollView+MM_Manager.h
//  Manager
//
//  Created by devfalme on 2018/12/18.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^StopScrollBlock)(UIScrollView *scrollView);
@interface UIScrollView (MM_Manager)
@property(nonatomic, copy) StopScrollBlock stopScrollBlock;
@end

NS_ASSUME_NONNULL_END
