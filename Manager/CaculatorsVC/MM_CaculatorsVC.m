//
//  MM_CaculatorsVC.m
//  Manager
//
//  Created by devfalme on 2019/1/3.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "MM_CaculatorsVC.h"
#import "MM_CaculatorsNavigationView.h"
#import "MM_SegmentView.h"
@interface MM_CaculatorsVC ()
@property (nonatomic, retain) MM_CaculatorsNavigationView *navigationView;
@property (nonatomic, retain) MM_SegmentView *segmentView;

@property (nonatomic, retain) UIViewController *FinancialVC;
@property (nonatomic, retain) UIViewController *houseLoanVC;
@property (nonatomic, retain) UIViewController *CarLoanVC;
@property (nonatomic, retain) UIViewController *WebLoanVC;


@property (nonatomic, retain) UIViewController *currentVC;
@end

@implementation MM_CaculatorsVC

ROUTER_PATH(@"CaculatorsVC")

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationView = [MM_CaculatorsNavigationView loadFromNib];
    [self.view addSubview:self.navigationView];
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(topSafeAera);
    }];
    
    self.segmentView = [[MM_SegmentView alloc]initWithAction:^(NSInteger index) {
        if (index == 0) {
            [self turnTo:self.FinancialVC];
        } else if (index == 1) {
            [self turnTo:self.houseLoanVC];
        } else if (index == 2) {
            [self turnTo:self.CarLoanVC];
        } else {
            [self turnTo:self.WebLoanVC];
        }
    }];
    self.segmentView.frame = CGRectMake(0, 30, 300, 30);
    self.segmentView.titleArray = @[@"理財",@"房貸",@"車貸",@"網貸"];
    
    self.segmentView.selectedBackgroundColor = yellowColor;
    self.segmentView.selectedBgViewCornerRadius = 15;
    self.segmentView.labelFont = [UIFont systemFontOfSize:14];
    
    self.segmentView.backgroundColor = lightColor;
    self.segmentView.layer.cornerRadius = 15;
    self.segmentView.layer.masksToBounds = YES;
    [self.navigationView.contentView addSubview:self.segmentView];
    [self.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.navigationView.contentView);
        make.size.mas_equalTo(CGSizeMake(300.0, 30.0));
    }];
    
    [self turnTo:self.FinancialVC];
}

- (void)turnTo:(UIViewController *)vc {
    if (self.currentVC) {
        [self.currentVC.view removeFromSuperview];
    }
    
    self.currentVC = vc;
    [self.view addSubview:self.currentVC.view];
    [self.currentVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationView.mas_bottom);
        make.left.bottom.right.equalTo(self.view);
    }];
}

- (BOOL)preferredNavigationBarHidden {
    return YES;
}

- (UIViewController *)FinancialVC {
    if (!_FinancialVC) {
        _FinancialVC = [Router search:ROUTER_API(@"FinancialVC") parameters:@{}];
        [self addChildViewController:_FinancialVC];
    }return _FinancialVC;
}

- (UIViewController *)houseLoanVC {
    if (!_houseLoanVC) {
        _houseLoanVC = [Router search:ROUTER_API(@"HouseLoanVC") parameters:@{}];
        [self addChildViewController:_houseLoanVC];
    }return _houseLoanVC;
}

- (UIViewController *)CarLoanVC {
    if (!_CarLoanVC) {
        _CarLoanVC = [Router search:ROUTER_API(@"CarLoanVC") parameters:@{}];
        [self addChildViewController:_CarLoanVC];
    }return _CarLoanVC;
}

- (UIViewController *)WebLoanVC {
    if (!_WebLoanVC) {
        _WebLoanVC = [Router search:ROUTER_API(@"WebLoanVC") parameters:@{}];
        [self addChildViewController:_WebLoanVC];
    }return _WebLoanVC;
}
@end
