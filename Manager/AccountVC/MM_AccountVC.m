//
//  MM_AccountVC.m
//  Manager
//
//  Created by devfalme on 2018/12/18.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_AccountVC.h"
#import "WSDatePickerView.h"
#import "MM_AccountCell.h"
#import "MM_AccountSectionView.h"
#import "MM_AccountBoardView.h"
@interface MM_AccountVC () <UIScrollViewDelegate>
@property (nonatomic, retain) UIButton *dateButton;
@property (nonatomic, retain) UIButton *addButton;

@property (nonatomic, assign) BOOL buttonAnimate;
@property (nonatomic, assign) BOOL firstTime;

@property (nonatomic, copy) NSString *dateString;

@property (nonatomic, retain) MM_AccountModel *model;
@end

@implementation MM_AccountVC

ROUTER_PATH(@"AccountVC")


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.tableView) {
        [self reload];
    }
}

- (void)didInitializeWithStyle:(UITableViewStyle)style {
    [super didInitializeWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"賬單";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.buttonAnimate = NO;
    self.tableView.bounces = YES;
    self.firstTime = YES;
    self.dateString = [[NSDate date] stringWithFormat:@"yy-MM"];
//    self.model = search(self.dateString);
    [[self.dateButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonth CompleteBlock:^(NSDate *selectDate) {
            
            NSString *dateString = [selectDate stringWithFormat:@"yy年MM月"];
            self.dateString = [selectDate stringWithFormat:@"yy-MM"];
            [self.dateButton setTitle:dateString forState:UIControlStateNormal];
            [self reload];
        }];
        datepicker.maxLimitDate = [NSDate date];
        datepicker.dateLabelColor = darkColor;
        datepicker.datePickerColor = darkColor;
        datepicker.doneButtonColor = yellowColor;
        [datepicker show];
    }];
    
    [self.view addSubview:self.dateButton];
    [self.dateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(@(-20.0));
        make.size.mas_equalTo(CGSizeMake(58, 58));
    }];
    
    [[self.addButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [Router post:ROUTER_API(@"MM_BillVC") parameters:@{} type:RouterTypePush];
    }];
    
    [self.view addSubview:self.addButton];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-20));
        make.bottom.equalTo(self.dateButton.mas_top).offset(-20);
        make.size.mas_equalTo(CGSizeMake(58, 58));
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MM_AccountCell" bundle:nil] forCellReuseIdentifier:@"MM_AccountCell"];
    
    MM_AccountBoardView *boardView = [MM_AccountBoardView model:self.model.header];
    UIView *a = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100.0)];
    [a addSubview:boardView];
    [boardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(a);
    }];
    self.tableView.tableHeaderView = a;
    
    UIButton *chartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    chartButton.frame = CGRectMake(0, 0, 44.0, 44.0);
    [chartButton setBackgroundImage:[UIImage imageNamed:@"ChartButton"] forState:UIControlStateNormal];
    chartButton.adjustsImageWhenDisabled = NO;
    chartButton.adjustsImageWhenHighlighted = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:chartButton];
    [[chartButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (self.model.sections.count) {
            [Router post:ROUTER_API(@"MM_ChartVC") parameters:@{@"model":self.model} type:RouterTypePush];
        }else{
            self.showError(@"請先添加一筆記錄");
        }
    }];
}

- (void)reload {
    self.model = search(self.dateString);
    MM_AccountBoardView *boardView = [MM_AccountBoardView model:self.model.header];
    UIView *a = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100.0)];
    [a addSubview:boardView];
    [boardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(a);
    }];
    self.tableView.tableHeaderView = a;
    [self.tableView reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.model.sections.count?self.model.sections.count:1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.sections.count?self.model.sections[section].cells.count:1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.model.sections.count) {
        MM_AccountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MM_AccountCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell updateCellAppearanceWithIndexPath:indexPath];
        return cell;
    }else{
        QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmptyCell"];
        if (!cell) {
            cell = [[QMUITableViewCell alloc]init];
            cell.contentView.backgroundColor = lightColor;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell updateCellAppearanceWithIndexPath:indexPath];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.model.sections.count) {
        return 40.0;
    }else{
        return 200.0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15.0)];
    view.backgroundColor = lightColor;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
     if (self.model.sections.count) {
         MM_AccountSectionView *sectionView = [MM_AccountSectionView model:self.model.sections[section]];
         return sectionView;
     }else{
         return [UIView new];
     }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.model.sections.count) {
        [(MM_AccountCell *)cell model:self.model.sections[indexPath.section].cells[indexPath.row]];
    }else{
        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"NoData"]];
        [cell.contentView addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.contentView).offset(20.0);
            make.centerX.equalTo(cell.contentView);
            make.size.mas_equalTo(CGSizeMake(210.0, 140.0));
        }];
        
        UILabel *title = [[UILabel alloc]init];
        title.text = @"点击+添加一笔记录";
        title.font = [UIFont systemFontOfSize:13.0];
        title.textColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(cell.contentView).offset(-20.0);
            make.centerX.equalTo(cell.contentView);
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.model.sections.count) {
        [Router post:ROUTER_API(@"MM_BillDetailVC") parameters:@{@"model":self.model.sections[indexPath.section].cells[indexPath.row]} type:RouterTypePush];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.buttonAnimate && !self.firstTime) {
        self.buttonAnimate = YES;
        [UIView animateWithDuration:.3 animations:^{
            self.addButton.transform = CGAffineTransformMakeScale(0.00001, 0.00001);
            self.dateButton.transform = CGAffineTransformMakeScale(0.00001, 0.00001);
        }];
    }
    self.firstTime = NO;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 停止类型1、停止类型2
    BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
    if (scrollToScrollStop) {
        [self scrollViewDidEndScroll];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self scrollViewDidEndScroll];
    }
}

#pragma mark - scrollView 滚动停止
- (void)scrollViewDidEndScroll {
    
//    NSLog(@"停止滚动了！！！");
    if (self.buttonAnimate) {
        [UIView animateWithDuration:.3 animations:^{
            self.addButton.transform = CGAffineTransformMakeScale(1, 1);
            self.dateButton.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            self.buttonAnimate = NO;
        }];
    }
}

- (UIButton *)dateButton {
    if (!_dateButton) {
        _dateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _dateButton.backgroundColor = [UIColor qmui_colorWithHexString:@"4C97FF"];
        _dateButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [_dateButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_dateButton setTitle:@"18年12月" forState:UIControlStateNormal];
        _dateButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _dateButton.cornerRadius = 29.0;
        _dateButton.shadowColor = [UIColor qmui_colorWithHexString:@"777777"];
        _dateButton.shadowOpacity = .5;
        _dateButton.shadowOffset = CGSizeMake(1, 3);
        _dateButton.shadowRadius = 4;
    }return _dateButton;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.backgroundColor = [UIColor qmui_colorWithHexString:@"FFDA47"];
        _addButton.titleLabel.font = [UIFont fontWithName:@"Courier" size:65];
        [_addButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_addButton setImage:[UIImage imageNamed:@"Add"] forState:UIControlStateNormal];
        _addButton.cornerRadius = 29.0;
        _addButton.shadowColor = [UIColor qmui_colorWithHexString:@"777777"];
        _addButton.shadowOpacity = .5;
        _addButton.shadowOffset = CGSizeMake(1, 3);
        _addButton.shadowRadius = 4;
        _addButton.adjustsImageWhenHighlighted = NO;
        _addButton.adjustsImageWhenDisabled = NO;
    }return _addButton;
}

@end
