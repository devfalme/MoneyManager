//
//  MM_BillModel.m
//  Manager
//
//  Created by devfalme on 2018/12/17.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_BillModel.h"
@interface MM_BillModel ()



@end
@implementation MM_BillModel
    
+ (instancetype)image:(NSString *)image highlightImage:(NSString *)highlightImage title:(NSString *)title {
    MM_BillModel *model = [[self alloc]init];
    model.image = image;
    model.highlightImage = highlightImage;
    model.title = title;
    model.highlight = NO;
    return model;
}
    
- (void)selected {
    self.highlight = !self.highlight;
}
@end
