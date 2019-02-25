//
//  MM_Client.h
//  Manager
//
//  Created by devfalme on 2018/12/17.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MM_AccountModel.h"

//1等额本息2等额本金
typedef NS_ENUM(NSUInteger, PayBackMethod) {
    PayBackMethodOne = 1,
    PayBackMethodTwo,
};

//汽车排量
//1 1.1-1.6
//2 1.7-2.0
//3 2.1-2.5
//4 2.6-3.0
//5 3.1-4.0
//6 4.0以上
//7 1.0以下
typedef NS_ENUM(NSUInteger, CarDisplacement) {
    CarDisplacementOne = 1,
    CarDisplacementTwo,
    CarDisplacementThree,
    CarDisplacementFour,
    CarDisplacementFive,
    CarDisplacementSix,
    CarDisplacementSeven,
};

//1活期 2定期
typedef NS_ENUM(NSUInteger, SavingType) {
    SavingTypeCurrent = 1,
    SavingTypeBound,
};

//1. 3个月 2. 6个月 3. 1年 4. 2年 5. 3年 6. 5年
typedef NS_ENUM(NSUInteger, SavingTime) {
    SavingTimeOne = 1,
    SavingTimeTwo,
    SavingTimeThree,
    SavingTimeFour,
    SavingTimeFive,
    SavingTimeSix,
};

typedef NS_ENUM(NSUInteger, TimeType) {
    TimeTypeMonth = 1,
    TimeTypeDay,
};

typedef NS_ENUM(NSUInteger, RateType) {
    RateTypeYear = 1,
    RateTypeDay,
};

//1按月付息到期还本2一次性还本付息3等额本息
typedef NS_ENUM(NSUInteger, PayBackType) {
    PayBackTypeOne,
    PayBackTypeTwo,
    PayBackTypeThree,
};

extern NSString *convertMethod(PayBackMethod);
extern NSString *convertDisplacement(CarDisplacement);
extern NSString *convertSavingType(SavingType);
extern NSString *convertSavingTime(SavingTime);
extern NSString *convertPayBack(PayBackType);

extern NSMutableArray *expendModels;
extern NSMutableArray *incomeModels;
extern CGFloat topSafeAera;
extern CGFloat bottomSafeAera;

extern UIColor *yellowColor;
extern UIColor *lightColor;
extern UIColor *darkColor;

extern NSString *homePath;

extern NSString *formatDate(NSDate *date);

extern NSDictionary *modelToDic(id obj);
extern void saveBill(MM_AccountCellModel *model);
extern void changeBill(MM_AccountCellModel *oldModel, MM_AccountCellModel *newModel);
extern void deleteBill(MM_AccountCellModel *model);
extern MM_AccountModel * search(NSString *date);

extern NSString *rootVC(void);
extern void appSetup(void);

extern void post(NSString *url, NSDictionary *parameter, void(^success)(id obj), void(^fail)(NSString *msg));

#define api(a) [NSString stringWithFormat:@"http://www.17miaojuan.com/%@",a]
