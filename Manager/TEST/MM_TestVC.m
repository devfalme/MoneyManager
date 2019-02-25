//
//  MM_TestVC.m
//  Manager
//
//  Created by devfalme on 2018/12/17.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_BillKeyboard.h"

#import "MM_TestVC.h"

@interface MM_TestVC ()

@end

@implementation MM_TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    MM_AccountModel *model = [[MM_AccountModel alloc]init];
//    NSLog(@"%@", [model dict]);
    
//    MM_BillKeyboard *a = [MM_BillKeyboard loadFromNib];
//
//    [self.view addSubview:a];
//    [a mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.bottom.right.equalTo(self.view);
//        make.height.mas_equalTo(bottomSafeAera + 220.0);
//    }];
    
    
    
    
   
    
    NSLog(@"%@", homePath);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [UIView animateWithDuration:.3 animations:^{
//        self.addButton.transform = CGAffineTransformMakeScale(1, 1);
//        self.dateButton.transform = CGAffineTransformMakeScale(1, 1);
//    }];
}
@end
