//
//  MM_ChartDetailVC.m
//  Manager
//
//  Created by devfalme on 2018/12/19.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_ChartDetailVC.h"
#import "MM_AccountCell.h"
@interface MM_ChartDetailVC ()

@property (nonatomic, retain) NSMutableArray<MM_AccountCellModel *> *modelArr;

@end

@implementation MM_ChartDetailVC

ROUTER_PATH(@"ChartDetailVC")

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"賬單";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = YES;
    [self.tableView registerNib:[UINib nibWithNibName:@"MM_AccountCell" bundle:nil] forCellReuseIdentifier:@"MM_AccountCell"];
    UIView *heaer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    heaer.backgroundColor = lightColor;
    self.tableView.tableHeaderView = heaer;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MM_AccountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MM_AccountCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell updateCellAppearanceWithIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [(MM_AccountCell *)cell model:self.modelArr[indexPath.row]];
}



@end
