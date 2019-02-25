//
//  MM_AdVC.m
//  Manager
//
//  Created by devfalme on 2018/12/19.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_AdVC.h"
#import "MM_BaseNavigationController.h"
@interface MM_AdVC () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation MM_AdVC

ROUTER_PATH(@"AdVC")

- (IBAction)startButtonAction:(id)sender {
    
    UIViewController *b = [Router search:ROUTER_API(@"TabbarVC") parameters:@{}];
    [self restoreRootViewController:b completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index=scrollView.contentOffset.x/scrollView.bounds.size.width;
    [_pageControl setCurrentPage:index];
}

@end
