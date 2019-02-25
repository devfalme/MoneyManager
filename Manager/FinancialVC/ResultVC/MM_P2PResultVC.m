//
//  MM_P2PResultVC.m
//  Calculator
//
//  Created by devfalme on 2018/12/13.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_P2PResultVC.h"
#import "MM_NormalCell.h"

@interface MM_P2PResultVC ()

@end

@implementation MM_P2PResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.bounces = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"MM_NormalCell" bundle:nil] forCellReuseIdentifier:@"MM_NormalCell"];
}


@end
