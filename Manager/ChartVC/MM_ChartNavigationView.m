//
//  MM_ChartNavigationView.m
//  Manager
//
//  Created by devfalme on 2018/12/19.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_ChartNavigationView.h"
@interface MM_ChartNavigationView ()

@property (weak, nonatomic) IBOutlet UIButton *returnButton;

@end
@implementation MM_ChartNavigationView

+ (instancetype)back:(void(^)(void))back {
    MM_ChartNavigationView *a = [MM_ChartNavigationView loadFromNib];
    [[a.returnButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        back();
    }];
    return a;
}

@end
