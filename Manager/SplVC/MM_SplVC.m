//
//  MM_SplVC.m
//  Manager
//
//  Created by devfalme on 2018/12/19.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_SplVC.h"

@interface MM_SplVC ()

@end

@implementation MM_SplVC

ROUTER_PATH(@"SplVC")

- (void)viewDidLoad {
    [super viewDidLoad];
    UIViewController *b = [Router search:ROUTER_API(rootVC()) parameters:@{}];
    [self restoreRootViewController:b completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
