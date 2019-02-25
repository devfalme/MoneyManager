//
//  MM_BaseVC.m
//  Manager
//
//  Created by devfalme on 2018/12/17.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_BaseVC.h"

@interface MM_BaseVC ()

@end

@implementation MM_BaseVC

- (void)viewWillDisappear:(BOOL)animated {
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    self.hideHud();
    [super viewWillDisappear:animated];
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.supportedOrientationMask = UIInterfaceOrientationMaskPortrait;
    self.view.backgroundColor = lightColor;
    
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
    
- (BOOL)shouldCustomizeNavigationBarTransitionIfHideable {
    return YES;
}
    
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
    
- (nullable UIColor *)titleViewTintColor {
    return lightColor;
}

- (nullable UIColor *)navigationBarBarTintColor {
    return darkColor;
}

- (nullable UIColor *)navigationBarTintColor {
    return lightColor;
}

@end
