//
//  MM_BillModel.h
//  Manager
//
//  Created by devfalme on 2018/12/17.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MM_BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MM_BillModel : MM_BaseModel
    
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *highlightImage;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL highlight;

+ (instancetype)image:(NSString *)image highlightImage:(NSString *)highlightImage title:(NSString *)title;

- (void)selected;
    
@end

NS_ASSUME_NONNULL_END
