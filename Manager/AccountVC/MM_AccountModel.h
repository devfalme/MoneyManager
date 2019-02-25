//
//  MM_AccountModel.h
//  Manager
//
//  Created by devfalme on 2018/12/18.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_BaseModel.h"

typedef NS_ENUM(NSUInteger, BillType) {
    BillTypeExpend = 0,
    BillTypeIncome,
};

NS_ASSUME_NONNULL_BEGIN

@class MM_AccountModel, MM_AccountHeaderModel, MM_AccountSectionModel, MM_AccountCellModel;

@interface MM_AccountModel : MM_BaseModel

@property (nonatomic, retain) MM_AccountHeaderModel *header;
@property (nonatomic, retain) NSMutableArray<MM_AccountSectionModel *> *sections;

- (void)addSection:(MM_AccountSectionModel *)section;

@end


@interface MM_AccountHeaderModel : MM_BaseModel
@property (nonatomic, retain) NSNumber *expend;
@property (nonatomic, retain) NSNumber *income;
@property (nonatomic, retain) NSNumber *surplus;

- (void)addSection:(MM_AccountSectionModel *)section;
- (void)addcell:(MM_AccountCellModel *)cell;

@end

@interface MM_AccountSectionModel : MM_BaseModel

@property (nonatomic, copy) NSString *date;
@property (nonatomic, retain) NSNumber *expend;
@property (nonatomic, retain) NSNumber *income;

@property (nonatomic, retain) NSMutableArray<MM_AccountCellModel *> *cells;

- (instancetype)initWithDate:(NSString *)date;

- (void)addCell:(MM_AccountCellModel *)cell;
@end

@interface MM_AccountCellModel : MM_BaseModel

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, retain) NSNumber *price;
@property (nonatomic, retain) NSString *tag;
@property (nonatomic, assign) BillType type;
@property (nonatomic, copy) NSString *date;
- (instancetype)initWithImage:(NSString *)image remark:(NSString *)remark price:(NSNumber *)price tag:(NSString *)tag rype:(BillType)type date:(NSString *)date;

@end

NS_ASSUME_NONNULL_END
