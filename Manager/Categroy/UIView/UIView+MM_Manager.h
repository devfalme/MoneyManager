//
//  UIView+MM_Manager.h
//  Manager
//
//  Created by devfalme on 2018/12/17.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
IB_DESIGNABLE
@interface UIView (MM_Manager)
@property (assign, nonatomic) IBInspectable UIColor *shadowColor;
@property (assign, nonatomic) IBInspectable CGFloat shadowOpacity;
@property (assign, nonatomic) IBInspectable CGSize shadowOffset;
@property (assign, nonatomic) IBInspectable CGFloat shadowRadius;

@property (assign, nonatomic) IBInspectable NSInteger borderWidth;
@property (strong, nonatomic) IBInspectable UIColor *borderColor;

@property (assign, nonatomic) IBInspectable NSInteger cornerRadius;
@property (assign, nonatomic) IBInspectable BOOL masksToBounds;


+ (instancetype)loadFromNib;
@end

NS_ASSUME_NONNULL_END
