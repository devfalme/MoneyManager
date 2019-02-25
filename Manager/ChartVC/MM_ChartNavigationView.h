//
//  MM_ChartNavigationView.h
//  Manager
//
//  Created by devfalme on 2018/12/19.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MM_ChartNavigationView : UIView
@property (weak, nonatomic) IBOutlet UIView *contentView;

+ (instancetype)back:(void(^)(void))back;
@end

NS_ASSUME_NONNULL_END
