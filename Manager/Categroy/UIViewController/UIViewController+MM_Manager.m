//
//  UIViewController+MM_Manager.m
//  Manager
//
//  Created by devfalme on 2018/12/19.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "UIViewController+MM_Manager.h"
#import <ChameleonFramework/Chameleon.h>
@implementation UIViewController (MM_Manager)
- (void(^)(UIView *))rightBarItem {
    return ^void(UIView *aView) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:aView];
    };
}


- (void (^)(NSString *))vcTitle {
    return ^void (NSString *aTitle) {
        [self setTitle:aTitle];
    };
}

- (void(^)(NSString *))showLoading {
    return ^void(NSString *aMsg) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [QMUITips hideAllTips];
            QMUITips *tips = [QMUITips showLoading:aMsg inView:DefaultTipsParentView];
            QMUIToastBackgroundView *backgroundView = (QMUIToastBackgroundView *)tips.backgroundView;
            backgroundView.shouldBlurBackgroundView = YES;
            backgroundView.styleColor = [UIColor colorWithHexString:[UIColor flatWhiteColor].hexValue withAlpha:.8];
            tips.tintColor = darkColor;
            
        });
        
    };
}

- (void (^)(NSString *))showText {
    return ^void(NSString *aMsg) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [QMUITips hideAllTips];
            QMUITips *tips = [QMUITips showInfo:aMsg];
            QMUIToastBackgroundView *backgroundView = (QMUIToastBackgroundView *)tips.backgroundView;
            backgroundView.shouldBlurBackgroundView = YES;
            backgroundView.styleColor = [UIColor colorWithHexString:[UIColor flatWhiteColor].hexValue withAlpha:.8];
            tips.tintColor = darkColor;
        });
    };
}

- (void (^)(void))hideHud {
    return ^void() {
        dispatch_async(dispatch_get_main_queue(), ^{
            [QMUITips hideAllTips];
        });
    };
}
- (void (^)(NSInteger))hideHudWhen {
    return ^void(NSInteger aTime) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(aTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [QMUITips hideAllTips];
        });
    };
}

- (void (^)(NSString *))showError {
    return ^void(NSString *aMsg) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [QMUITips hideAllTips];
            QMUITips *tips = [QMUITips showError:aMsg];
            QMUIToastBackgroundView *backgroundView = (QMUIToastBackgroundView *)tips.backgroundView;
            backgroundView.shouldBlurBackgroundView = YES;
            backgroundView.styleColor = [UIColor colorWithHexString:[UIColor flatWhiteColor].hexValue withAlpha:.8];
            tips.tintColor = darkColor;
        });
    };
}

- (void (^)(NSString *))showSuccess {
    return ^void(NSString *aMsg) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [QMUITips hideAllTips];
            QMUITips *tips = [QMUITips showSucceed:aMsg];
            QMUIToastBackgroundView *backgroundView = (QMUIToastBackgroundView *)tips.backgroundView;
            backgroundView.shouldBlurBackgroundView = YES;
            backgroundView.styleColor = [UIColor colorWithHexString:[UIColor flatWhiteColor].hexValue withAlpha:.8];
            tips.tintColor = darkColor;
        });
    };
}

- (void (^)(void))vcPop {
    return ^void (void) {
        if (self.navigationController.viewControllers.count > 1) {
            [self.view endEditing:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self.view endEditing:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    };
}

- (void (^)(UIViewController *))vcPush {
    return ^void (UIViewController *aVc) {
        if ([aVc isKindOfClass:[UIViewController class]]) {
            if (self.navigationController) {
                [self.navigationController pushViewController:aVc animated:YES];
            }
        }
    };
}

- (void (^)(UIViewController * _Nonnull))vcAddChildVC {
    return ^void (UIViewController *childVC) {
        if ([childVC isKindOfClass:[UIViewController class]]) {
            [self addChildViewController:childVC];
        }
    };
}

- (void)restoreRootViewController:(UIViewController *)rootViewController completion:(void (^)(BOOL finished))completion{
    
    typedef void (^Animation)(void);
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        window.rootViewController = rootViewController;
        [UIView setAnimationsEnabled:oldState];
    };
    
    [UIView transitionWithView:window
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:completion];
    
}
@end
