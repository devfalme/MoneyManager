//
//  MM_AccountModel.m
//  Manager
//
//  Created by devfalme on 2018/12/18.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_AccountModel.h"

@implementation MM_AccountModel

- (instancetype)init {
    if (self = [super init]) {
        self.header = [[MM_AccountHeaderModel alloc]init];
        self.sections = [NSMutableArray array];
    }return self;
}
- (void)addSection:(MM_AccountSectionModel *)section {
    [self.header addSection:section];
    [self.sections addObject:section];
    self.sections = [[self.sections sortedArrayUsingComparator:^NSComparisonResult(MM_AccountSectionModel *obj1, MM_AccountSectionModel *obj2) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YY-MM-dd"];
        NSDate *datestr1 = [dateFormatter dateFromString:obj1.date];
        NSDate *datestr2 = [dateFormatter dateFromString:obj2.date];
        
        if ([datestr1 timeIntervalSince1970] > [datestr2 timeIntervalSince1970]) {
            return NSOrderedDescending;
        }else{
            return NSOrderedAscending;
        }
    }] mutableCopy];
}



+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"header":[MM_AccountHeaderModel class],
             @"sections":[MM_AccountSectionModel class]
             };
}

@end

@implementation MM_AccountHeaderModel

- (instancetype)init {
    if (self = [super init]) {
        self.expend = @0;
        self.income = @0;
        self.surplus = @0;
    }return self;
}

- (void)addSection:(MM_AccountSectionModel *)section {
    self.expend = @(self.expend.doubleValue + section.expend.doubleValue);
    self.income = @(self.income.doubleValue + section.income.doubleValue);
    self.surplus = @(self.expend.doubleValue + self.income.doubleValue);
}

- (void)addcell:(MM_AccountCellModel *)cell {
    if (cell.type == BillTypeExpend) {
        self.expend = @(self.expend.doubleValue + cell.price.doubleValue);
    }else{
        self.income = @(self.income.doubleValue + cell.price.doubleValue);
    }
    self.surplus = @(self.income.doubleValue + self.expend.doubleValue);
    
}
@end

@implementation MM_AccountSectionModel

- (instancetype)initWithDate:(NSString *)date {
    if (self = [super init]) {
        self.date = date;
        self.expend = @0;
        self.income = @0;
        self.cells = [NSMutableArray array];
    }return self;
}

- (void)addCell:(MM_AccountCellModel *)cell {
    [self.cells addObject:cell];
    double price = cell.price.doubleValue;
    if (price > 0) {
        self.income = @(self.income.doubleValue + price);
    }else{
        self.expend = @(self.expend.doubleValue + price);
    }
    
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"cells":[MM_AccountCellModel class],
             };
}
@end

@implementation MM_AccountCellModel

- (instancetype)initWithImage:(NSString *)image remark:(NSString *)remark price:(NSNumber *)price tag:(NSString *)tag rype:(BillType)type date:(NSString *)date {
    if (self = [super init]) {
        self.imageName = image;
        self.remark = remark;
        self.price = price;
        self.tag = tag;
        self.type = type;
        self.date = date;
    }return self;
}

@end
