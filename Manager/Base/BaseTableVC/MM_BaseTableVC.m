//
//  MM_BaseTableVC.m
//  Manager
//
//  Created by devfalme on 2018/12/17.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_BaseTableVC.h"

@interface MM_BaseTableVC ()

@end

@implementation MM_BaseTableVC

- (void)viewWillDisappear:(BOOL)animated {
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    self.hideHud();
    [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = lightColor;
    self.tableView.backgroundColor = lightColor;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.supportedOrientationMask = UIInterfaceOrientationMaskPortrait;
    
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
