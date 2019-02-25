//
//  MM_BillCell.m
//  Manager
//
//  Created by devfalme on 2018/12/17.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_BillCell.h"
@interface MM_BillCell ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@end
@implementation MM_BillCell

- (void)model:(MM_BillModel *)model {
    self.image.image = [UIImage imageNamed:model.highlight?model.highlightImage:model.image];
    self.title.text = model.title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

@end
