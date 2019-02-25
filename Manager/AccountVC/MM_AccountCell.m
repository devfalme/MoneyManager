//
//  MM_AccountCell.m
//  Manager
//
//  Created by devfalme on 2018/12/18.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_AccountCell.h"
@interface MM_AccountCell ()
@property (weak, nonatomic) IBOutlet UIImageView *tagImageView;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
@implementation MM_AccountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)model:(MM_AccountCellModel *)model {
    self.tagImageView.image = [UIImage imageNamed:model.imageName];
    self.remarkLabel.text = model.remark;
    self.priceLabel.text = model.price.stringValue;
}
@end
