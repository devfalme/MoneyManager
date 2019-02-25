//
//  MM_TabbarVC.m
//  Manager
//
//  Created by devfalme on 2019/1/3.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "MM_TabbarVC.h"
#import "MM_BaseNavigationController.h"

@interface MM_TabbarVC ()

@end

@implementation MM_TabbarVC

ROUTER_PATH(@"TabbarVC")


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)setUp {
    UIViewController *publishCtrl = [Router search:ROUTER_API(@"AccountVC") parameters:@{}];
    [self addChildViewController:publishCtrl imageName:@"Pig" title:@"賬本"];

    UIViewController *homeCtrl = [Router search:ROUTER_API(@"CaculatorsVC") parameters:@{}];
    [self addChildViewController:homeCtrl imageName:@"Caculator" title:@"多功能計算器"];
}


- (void)addChildViewController:(UIViewController *)childCtrl imageName:(NSString *)imageName title:(NSString *)title{
    
    childCtrl.tabBarItem.image = [[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childCtrl.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@Highlight",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置标题
    childCtrl.title = title;
    //
    //    //指定一下属性
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor qmui_colorWithHexString:@"#797A79"];
    //
    [childCtrl.tabBarItem setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    MM_BaseNavigationController *navCtrl = [[MM_BaseNavigationController alloc] initWithRootViewController:childCtrl];
    
    
    [self addChildViewController:navCtrl];
    
    
    
}

@end
