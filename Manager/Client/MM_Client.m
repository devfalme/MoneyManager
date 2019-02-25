//
//  MM_Client.m
//  Manager
//
//  Created by devfalme on 2018/12/17.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_Client.h"
#import "MM_BillModel.h"
#import <AFNetworking/AFNetworking.h>

#define FirstKey @"first"
#define LocalNotifFlag @"localNotifFlag"

NSMutableArray *expendModels = NULL;
NSMutableArray *incomeModels = NULL;

CGFloat topSafeAera = 0;
CGFloat bottomSafeAera = 0;

UIColor *yellowColor = NULL;
UIColor *lightColor = NULL;
UIColor *darkColor = NULL;

NSString *homePath = NULL;

NSString *rootVC(void) {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:FirstKey]) {
        return @"TabbarVC";
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:FirstKey];
        return @"AdVC";
    }
}

NSString *formatDate(NSDate *date) {
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString* string=[dateFormat stringFromDate:date];
    return string;
}

MM_AccountModel * search(NSString *date) {
    NSString *path = [homePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", date]];
    NSLog(@"正在搜索文件 \n %@ \n", path);
    BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:path];
    if (!exist) {
        NSLog(@"文件不存在， 正在创建文件");
        BOOL createFlag = [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
        NSLog(@"创建%@", createFlag?@"成功":@"失败");
    }
    NSLog(@"正在提取文件");
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSLog(@"文件提取如下: \n %@", dict);
    NSLog(@"正在还原数据");
    MM_AccountModel *accountModel;
    if (dict.count) {
        accountModel = [[MM_AccountModel alloc]initWithDict:dict];
    }else{
        accountModel = [[MM_AccountModel alloc]init];
    }
    NSLog(@"还原成功！数据如下：\n%@", [accountModel dict]);
    return accountModel;
}

//18-12-15
void saveBill(MM_AccountCellModel *model) {
    NSLog(@"---------存储新数据-----------");
    NSString *path = [homePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", [model.date substringWithRange:NSMakeRange(0, 5)]]];
    NSLog(@"正在向 \n %@ \n中写入数据", path);
    BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:path];
    if (exist) {
        NSLog(@"文件存在， 正在提取文件");
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
        NSLog(@"文件提取如下: \n %@", dict);
        NSLog(@"正在还原数据");
        MM_AccountModel *accountModel;
        if (dict.count) {
            accountModel = [[MM_AccountModel alloc]initWithDict:dict];
        }else{
            accountModel = [[MM_AccountModel alloc]init];
        }
        NSLog(@"还原成功！数据如下：\n%@", [accountModel dict]);
        NSLog(@"查找当前日期是否已有数据");
        BOOL flag = NO;
        for (MM_AccountSectionModel *sectionModel in accountModel.sections) {
            if ([sectionModel.date isEqualToString:model.date]) {
                NSLog(@"已找到现有数据，即将插入新数据");
                [sectionModel addCell:model];
                [accountModel.header addcell:model];
                flag = YES;
                break;
            }
        }
        if (!flag) {
            NSLog(@"未找到已有数据，正在创建新数据");
            MM_AccountSectionModel *sectionModel = [[MM_AccountSectionModel alloc]initWithDate:model.date];
            [sectionModel addCell:model];
            [accountModel addSection:sectionModel];
        }
        NSLog(@"数据插入成功！");
        NSLog(@"数据改变为：\n%@", [accountModel dict]);
        NSLog(@"即将写入文件");
        BOOL writeFlag = [[accountModel dict] writeToFile:path atomically:NO];
        NSLog(@"写入%@", writeFlag?@"成功":@"失败");
        
    }else{
        NSLog(@"文件不存在， 正在创建文件");
        BOOL createFlag = [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
        NSLog(@"创建%@", createFlag?@"成功":@"失败");
        MM_AccountSectionModel *sectionModel = [[MM_AccountSectionModel alloc]initWithDate:model.date];
        [sectionModel addCell:model];
        
        MM_AccountModel *model = [[MM_AccountModel alloc]init];
        [model addSection:sectionModel];
        NSLog(@"添加如下：");
        NSLog(@"%@", [model dict]);
        NSLog(@"即将写入文件");
        BOOL flag = [[model dict] writeToFile:path atomically:NO];
        NSLog(@"写入%@", flag?@"成功":@"失败");
    }
    NSLog(@"-----------------------------");
}
void changeBill(MM_AccountCellModel *oldModel, MM_AccountCellModel *newModel) {
    NSLog(@"----------修改数据------------");
    deleteBill(oldModel);
    saveBill(newModel);
    NSLog(@"-----------------------------");
}

void deleteBill(MM_AccountCellModel *model) {
    NSLog(@"----------删除数据------------");
    NSString *oldPath = [homePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", [model.date substringWithRange:NSMakeRange(0, 5)]]];
    NSLog(@"正在往 \n %@ \n中删除旧数据", oldPath);
    NSLog(@"正在提取文件");
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:oldPath];
    NSLog(@"文件提取成功, 正在还原数据");
    MM_AccountModel *accountModel;
    if (dict.count) {
        accountModel = [[MM_AccountModel alloc]initWithDict:dict];
    }else{
        accountModel = [[MM_AccountModel alloc]init];
    }
    NSLog(@"还原成功！数据如下：\n%@", [accountModel dict]);
    NSLog(@"开始匹配原数据");
    MM_AccountCellModel *tempCellModel;
    MM_AccountSectionModel *tempSectionModel;
    for (MM_AccountSectionModel *sectionModel in accountModel.sections) {
        if ([sectionModel.date isEqualToString:model.date]) {
            tempSectionModel = sectionModel;
            for (MM_AccountCellModel *cellModel in sectionModel.cells) {
                if ([cellModel.imageName isEqualToString:model.imageName] && [cellModel.remark isEqualToString:model.remark] && [model.price isEqualToNumber:model.price]) {
                    NSLog(@"已找到旧数据");
                    tempCellModel = cellModel;
                    break;
                }
            }
            break;
        }
    }
    if (!tempCellModel) {
        NSLog(@"未找到旧数据，删除失败");
    }else{
        if (tempCellModel.type == BillTypeExpend) {
            accountModel.header.expend = @(accountModel.header.expend.doubleValue - tempCellModel.price.doubleValue);
            tempSectionModel.expend = @(tempSectionModel.expend.doubleValue - tempCellModel.price.doubleValue);
        }else{
            accountModel.header.income = @(accountModel.header.income.doubleValue - tempCellModel.price.doubleValue);
            tempSectionModel.income = @(tempSectionModel.income.doubleValue - tempCellModel.price.doubleValue);
        }
        accountModel.header.surplus = @(accountModel.header.income.doubleValue + accountModel.header.expend.doubleValue);
        [tempSectionModel.cells removeObject:tempCellModel];
        
        if (tempSectionModel.cells.count == 0) {
            [accountModel.sections removeObject:tempSectionModel];
        }
        
        NSLog(@"删除成功！");
        NSLog(@"新数据如下：%@", [accountModel dict]);
        NSLog(@"更新数据文件");
        BOOL writeFlag = [[accountModel dict] writeToFile:oldPath atomically:NO];
        NSLog(@"更新%@", writeFlag?@"成功":@"失败");
    }
    NSLog(@"-----------------------------");
}

void appSetup(void) {
    homePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) firstObject] stringByAppendingPathComponent:@"dataPlist"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:homePath]) {
        BOOL flag = [[NSFileManager defaultManager] createDirectoryAtPath:homePath withIntermediateDirectories:YES attributes:nil error:nil];
        NSLog(@"初始化文件夹%@", flag?@"成功":@"失败");
    }
    [[NSUserDefaults standardUserDefaults] setObject:@([NSDate date].timeIntervalSince1970) forKey:LocalNotifFlag];
    topSafeAera = ([[UIApplication sharedApplication] statusBarFrame].size.height > 20.0 ? 88.0 : 64.0);
    bottomSafeAera = ([[UIApplication sharedApplication] statusBarFrame].size.height > 20.0 ? 34.0 : 0.0);
    
    yellowColor = [UIColor qmui_colorWithHexString:@"FFDA47"];
    lightColor = [UIColor qmui_colorWithHexString:@"F2F3F4"];
    darkColor = [UIColor qmui_colorWithHexString:@"404040"];
    
    expendModels = [NSMutableArray array];
    incomeModels = [NSMutableArray array];
    
    NSString *expend = [[NSBundle mainBundle] pathForResource:@"BillExpend" ofType:@"plist"];
    NSString *income = [[NSBundle mainBundle] pathForResource:@"BillIncome" ofType:@"plist"];
    NSArray *expendArr = [NSArray arrayWithContentsOfFile:expend];
    NSArray *incomeArr = [NSArray arrayWithContentsOfFile:income];
    for (NSDictionary *dict in expendArr) {
        MM_BillModel *model = [[MM_BillModel alloc]initWithDict:dict];
        [expendModels addObject:model];
    }
    for (NSDictionary *dict in incomeArr) {
        MM_BillModel *model = [[MM_BillModel alloc]initWithDict:dict];
        [incomeModels addObject:model];
    }
    
    
    RouterStart;
//    [QMUIConfiguration sharedInstance].statusbarStyleLightInitially = YES;
//    [QMUIAlertController appearance].sheetButtonAttributes = @{NSForegroundColorAttributeName:darkColor(),NSFontAttributeName:UIFontMake(20),NSKernAttributeName:@(0)};
//    [QMUIAlertController appearance].sheetCancelButtonAttributes = @{NSForegroundColorAttributeName:greyColor(),NSFontAttributeName:UIFontBoldMake(20),NSKernAttributeName:@(0)};
    
}

NSString *convertMethod(PayBackMethod method) {
    if (method == PayBackMethodOne) {
        return @"等额本息";
    }else{
        return @"等额本金";
    }
}
NSString *convertPayBack(PayBackType type) {
    switch (type) {
        case PayBackTypeOne:
            return @"按月付息到期还本";
            break;
        case PayBackTypeTwo:
            return @"一次性还本付息";
            break;
        default:
            return @"等额本息";
            break;
    }
}
NSString *convertDisplacement(CarDisplacement dis) {
    switch (dis) {
        case CarDisplacementOne:
            return @"1.1 - 1.6";
            break;
        case CarDisplacementTwo:
            return @"1.7 - 2.0";
            break;
        case CarDisplacementThree:
            return @"2.1 - 2.5";
            break;
        case CarDisplacementFour:
            return @"2.6 - 3.0";
            break;
        case CarDisplacementFive:
            return @"3.1 - 4.0";
            break;
        case CarDisplacementSix:
            return @"4.0以上";
            break;
        default:
            return @"1.0以下";
            break;
    }
}

NSString *convertSavingType(SavingType type) {
    switch (type) {
        case SavingTypeCurrent:
            return @"活期";
            break;
        default:
            return @"定期";
            break;
    }
}

NSString *convertSavingTime(SavingTime type) {
    switch (type) {
        case SavingTimeOne:
            return @"3个月";
            break;
        case SavingTimeTwo:
            return @"6个月";
            break;
        case SavingTimeThree:
            return @"1年";
            break;
        case SavingTimeFour:
            return @"2年";
            break;
        case SavingTimeFive:
            return @"3年";
            break;
        default:
            return @"5年";
            break;
    }
}

void post(NSString *url, NSDictionary *parameter, void(^success)(id obj), void(^fail)(NSString *msg)) {
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.responseSerializer = [AFJSONResponseSerializer serializer];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil, nil];
    
    [manage POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        NSString *message = [NSString stringWithFormat:@"%@",responseObject[@"message"]];
        if ([code isEqualToString:@"200"]) {
            success(responseObject);
        }else{
            fail(message);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(@"网络不畅！");
    }];
}
