//
//  MM_ExpendVC.m
//  Manager
//
//  Created by devfalme on 2018/12/19.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_ExpendChartVC.h"
#import "DVPieChart.h"
#import "DVFoodPieModel.h"

@interface MM_ExpendChartVC ()

@property (weak, nonatomic) IBOutlet UILabel *totalBill;
@property (weak, nonatomic) IBOutlet UILabel *totalMoney;
@property (weak, nonatomic) IBOutlet UIButton *billButton;
@property (weak, nonatomic) IBOutlet UIView *chartView;


@property (nonatomic, retain) MM_AccountModel *model;

@property (nonatomic, retain) NSMutableArray <MM_AccountCellModel *> *cellModels;

@end

@implementation MM_ExpendChartVC
- (instancetype)initWithModel:(MM_AccountModel *)model {
    if (self = [super init]) {
        self.model = model;
        self.cellModels = [NSMutableArray array];
    }return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSNumber *totalMoney = @0;
    NSNumber *billNumber = @0;
    for (MM_AccountSectionModel *sectionModel in self.model.sections) {
        for (MM_AccountCellModel *cellModel in sectionModel.cells) {
            NSNumber *price = [dict objectForKey:cellModel.remark];
            if (cellModel.type == BillTypeExpend) {
                if (!price) {
                    price = cellModel.price;
                    [dict setObject:price forKey:cellModel.remark];
                }else{
                    price = @(price.doubleValue + cellModel.price.doubleValue);
                    [dict setObject:price forKey:cellModel.remark];
                }
                totalMoney = @(totalMoney.doubleValue + cellModel.price.doubleValue);
                billNumber = @(billNumber.doubleValue + 1);
                [self.cellModels addObject:cellModel];
            }
        }
    }
    self.totalMoney.text = totalMoney.stringValue;
    self.totalBill.text = [NSString stringWithFormat:@"（共%@笔）", billNumber.stringValue];
    
    DVPieChart *chart = [[DVPieChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-30.0, 320)];
    
    [self.chartView addSubview:chart];
    NSArray *keys = [dict allKeys];
    NSMutableArray *chartArr = [NSMutableArray array];
    for (NSString *key in keys) {
        NSNumber *money = dict[key];
        DVFoodPieModel *model = [[DVFoodPieModel alloc] init];
        
        model.rate = money.doubleValue / totalMoney.doubleValue;
        model.name = key;
        model.value = money.doubleValue;
        
        [chartArr addObject:model];
    }
    chart.dataArray = chartArr;
    chart.title = @"支出";
    [chart draw];
    
    [[self.billButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [Router post:ROUTER_API(@"ChartDetailVC") parameters:@{@"modelArr":self.cellModels} type:RouterTypePush];
    }];
    
}

@end
