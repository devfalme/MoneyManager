//
//  MM_AccountSectionView.m
//  Manager
//
//  Created by devfalme on 2018/12/18.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_AccountSectionView.h"
@interface MM_AccountSectionView ()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *expendLabel;
@property (weak, nonatomic) IBOutlet UILabel *incomeLabel;

@end
@implementation MM_AccountSectionView

+ (instancetype)model:(MM_AccountSectionModel *)model {
    MM_AccountSectionView *section = [self loadFromNib];
    section.dateLabel.text = model.date;
    section.expendLabel.text = model.expend.stringValue;
    section.incomeLabel.text = model.income.stringValue;
    return section;
}

@end
