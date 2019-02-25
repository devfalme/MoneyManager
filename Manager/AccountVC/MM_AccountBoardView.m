//
//  MM_AccountBoardView.m
//  Manager
//
//  Created by devfalme on 2018/12/18.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_AccountBoardView.h"
@interface MM_AccountBoardView ()
@property (weak, nonatomic) IBOutlet UILabel *expendLabel;
@property (weak, nonatomic) IBOutlet UILabel *SurplusLabel;
@property (weak, nonatomic) IBOutlet UILabel *incomeLabel;

@end
@implementation MM_AccountBoardView

+ (instancetype)model:(MM_AccountHeaderModel *)model {
    MM_AccountBoardView *boardView = [self loadFromNib];
    boardView.expendLabel.text = model.expend.stringValue?model.expend.stringValue:@"0";
    boardView.incomeLabel.text = model.income.stringValue?model.income.stringValue:@"0";
    boardView.SurplusLabel.text = model.surplus.stringValue?model.surplus.stringValue:@"0";
    return boardView;
}

@end
