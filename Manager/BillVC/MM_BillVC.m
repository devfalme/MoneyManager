//
//  MM_BillVC.m
//  Manager
//
//  Created by devfalme on 2018/12/17.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_BillVC.h"
#import "MM_SegmentView.h"
#import "MM_BillNavigationView.h"
#import "MM_IncomeVC.h"
#import "MM_ExpendVC.h"

@interface MM_BillVC ()

@property (nonatomic, retain) MM_BillNavigationView *navigationView;

@property (nonatomic, retain) MM_SegmentView *segmentView;

@property (nonatomic, retain) MM_ExpendVC *expendVC;
@property (nonatomic, retain) MM_IncomeVC *incomeVC;

@property (nonatomic, retain) UIViewController *currentVC;
@end

@implementation MM_BillVC

ROUTER_PATH(@"MM_BillVC")

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationView = [MM_BillNavigationView back:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:self.navigationView];
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(topSafeAera);
    }];
    
    self.segmentView = [[MM_SegmentView alloc]initWithAction:^(NSInteger index) {
        if (index) {
            [self turnTo:self.incomeVC];
        } else {
            [self turnTo:self.expendVC];
        }
    }];
    self.segmentView.frame = CGRectMake(0, 30, 150, 30);
    self.segmentView.titleArray = @[@"支出",@"收入"];
    
    self.segmentView.selectedBackgroundColor = yellowColor;
    self.segmentView.selectedBgViewCornerRadius = 15;
    self.segmentView.labelFont = [UIFont systemFontOfSize:14];
    
    self.segmentView.backgroundColor = lightColor;
    self.segmentView.layer.cornerRadius = 15;
    self.segmentView.layer.masksToBounds = YES;
    [self.navigationView.contentView addSubview:self.segmentView];
    [self.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.navigationView.contentView);
        make.size.mas_equalTo(CGSizeMake(150.0, 30.0));
    }];
    
    [self turnTo:self.expendVC];
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

- (MM_ExpendVC *)expendVC {
    if (!_expendVC) {
        _expendVC = [[MM_ExpendVC alloc]init];
        [self addChildViewController:_expendVC];
    }return _expendVC;
}

- (MM_IncomeVC *)incomeVC {
    if (!_incomeVC) {
        _incomeVC = [[MM_IncomeVC alloc]init];
        [self addChildViewController:_incomeVC];
    }return _incomeVC;
}

- (BOOL)preferredNavigationBarHidden {
    return YES;
}
@end

