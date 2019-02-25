//
//  MM_BillDetailVC.m
//  Manager
//
//  Created by devfalme on 2018/12/19.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_BillDetailVC.h"

@interface MM_BillDetailVC ()
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *remark;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, retain) MM_AccountCellModel *model;

@end

@implementation MM_BillDetailVC

ROUTER_PATH(@"MM_BillDetailVC")

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"賬單詳情";
    self.imageView.image = [UIImage imageNamed:self.model.imageName];
    self.tagLabel.text = self.model.tag;
    self.categoryLabel.text = self.model.type == BillTypeExpend?@"支出":@"收入";
    self.moneyLabel.text = self.model.price.stringValue;
    self.dateLabel.text = self.model.date;
    self.remark.text = self.model.remark;
    
    UIButton *chartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    chartButton.frame = CGRectMake(0, 0, 44.0, 44.0);
    [chartButton setBackgroundImage:[UIImage imageNamed:@"DeleteButton"] forState:UIControlStateNormal];
    chartButton.adjustsImageWhenDisabled = NO;
    chartButton.adjustsImageWhenHighlighted = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:chartButton];
    [[chartButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        deleteBill(self.model);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}
- (IBAction)editButtonAction:(id)sender {
    [Router post:ROUTER_API(@"MM_EditVC") parameters:@{@"model":self.model,@"change":^(MM_AccountCellModel *model) {
        self.imageView.image = [UIImage imageNamed:model.imageName];
        self.tagLabel.text = model.tag;
        self.categoryLabel.text = model.type == BillTypeExpend?@"支出":@"收入";
        self.moneyLabel.text = model.price.stringValue;
        self.dateLabel.text = model.date;
        self.remark.text = model.remark;
    }} type:RouterTypePush];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
