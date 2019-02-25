//
//  MM_BillNavigationView.m
//  Manager
//
//  Created by devfalme on 2018/12/17.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_BillNavigationView.h"
@interface MM_BillNavigationView ()
@property (weak, nonatomic) IBOutlet UIButton *returnButton;

@end
@implementation MM_BillNavigationView

+ (instancetype)back:(void(^)(void))back {
    MM_BillNavigationView *a = [MM_BillNavigationView loadFromNib];
    [[a.returnButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        back();
    }];
    return a;
}

@end
