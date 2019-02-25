//
//  MM_EditIncomeVC.m
//  Manager
//
//  Created by devfalme on 2018/12/19.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_EditIncomeVC.h"
#import "MM_BillCell.h"
#import "MM_BillKeyboard.h"
#import "WSDatePickerView.h"
@interface MM_EditIncomeVC () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (nonatomic, retain) NSMutableArray<MM_BillModel *> *dataSource;

@property (nonatomic, retain) MM_BillModel *selectModel;

@property (nonatomic, retain) MM_BillKeyboard *keyboard;

@property (nonatomic, copy) NSString *dateString;

@property (nonatomic, retain) MM_AccountCellModel *oldModel;

@property (nonatomic, copy) void(^change)(MM_AccountCellModel *);
@end

@implementation MM_EditIncomeVC
- (instancetype)initWithModel:(MM_AccountCellModel *)model change:(void(^)(MM_AccountCellModel *model))change {
    if (self = [super init]) {
        self.oldModel = model;
        self.change = change;
    }return self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    // 键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark -键盘监听方法
- (void)keyboardWasShown:(NSNotification *)notification {
    // 获取键盘的高度
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [self.keyboard updateConstraintsIfNeeded];
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:.3 animations:^{
        [self.keyboard mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.height.mas_equalTo(frame.size.height + 44.0);
        }];
        [self.keyboard updateConstraintsIfNeeded];
        [self.view layoutIfNeeded];
    }];
    
    
}
- (void)keyboardWillBeHiden:(NSNotification *)notification {
    [self keyboardShow];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = incomeModels;
    [self setupCollection];
    NSString *dateString = [[NSDate date] stringWithFormat:@"YY-MM-dd"];
    self.dateString = dateString;
    self.keyboard = [MM_BillKeyboard date:^{
        WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
            NSString *dateString = [selectDate stringWithFormat:@"YY-MM-dd"];
            self.dateString = dateString;
            [self.keyboard date:dateString];
        }];
        datepicker.maxLimitDate = [NSDate date];
        datepicker.dateLabelColor = darkColor;
        datepicker.datePickerColor = darkColor;
        datepicker.doneButtonColor = yellowColor;
        [datepicker show];
    } action:^(NSString * _Nonnull remark, NSNumber * _Nonnull price) {
        if (price.doubleValue < 0) {
            price = @(-price.doubleValue);
        }else{
            price = price;
        }
        MM_AccountCellModel *model = [[MM_AccountCellModel alloc]initWithImage:self.selectModel.highlightImage remark:remark price:price tag:self.selectModel.title rype:BillTypeIncome date:self.dateString];
        changeBill(self.oldModel, model);
        [self keyboardHiden];
        [self.selectModel selected];
        self.selectModel = nil;
        [self.collectionView reloadData];
        self.change(model);
        self.showSuccess(@"修改成功！");
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:self.keyboard];
    [self.keyboard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(bottomSafeAera + 220.0);
    }];
}

- (void)setupCollection {
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.alwaysBounceHorizontal = NO;
    //注册Cell，必须要有
    [self.collectionView registerNib:[UINib nibWithNibName:@"MM_BillCell" bundle:nil] forCellWithReuseIdentifier:@"MM_BillCell"];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
}

#pragma mark - UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"MM_BillCell";
    MM_BillCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [(MM_BillCell *)cell model:self.dataSource[indexPath.row]];
}

#pragma mark - UICollectionViewDelegateFlowLayout


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat w = (SCREEN_WIDTH - 100)/4.0;
    CGFloat h = w + 13;
    
    return CGSizeMake(w, h);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 20, 20, 20);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 20;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectModel) {
        [self.selectModel selected];
    }
    if (![self.selectModel isEqual:self.dataSource[indexPath.row]]) {
        self.selectModel = self.dataSource[indexPath.row];
        [self.selectModel selected];
        [self.keyboard imageName:self.selectModel.highlightImage];
        [self.keyboard placehold:self.selectModel.title];
        [self keyboardShow];
    }else{
        self.selectModel = nil;
        [self keyboardHiden];
    }
    [self.collectionView reloadData];
}

- (void)keyboardShow {
    [self.view layoutIfNeeded];
    [self.keyboard date:self.dateString];
    [self.keyboard updateConstraintsIfNeeded];
    [UIView animateWithDuration:.3 animations:^{
        [self.keyboard mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.height.mas_equalTo(bottomSafeAera + 220.0);
        }];
        [self.keyboard updateConstraintsIfNeeded];
        [self.view layoutIfNeeded];
    }];
    
}

- (void)keyboardHiden {
    [self.view layoutIfNeeded];
    [self.keyboard updateConstraintsIfNeeded];
    [self.keyboard reload];
    NSString *dateString = [[NSDate date] stringWithFormat:@"YY-MM-dd"];
    self.dateString = dateString;
    [UIView animateWithDuration:.3 animations:^{
        [self.keyboard mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.mas_equalTo(self.view.mas_bottom);
            make.height.mas_equalTo(bottomSafeAera + 220.0);
        }];
        [self.keyboard updateConstraintsIfNeeded];
        [self.view layoutIfNeeded];
    }];
    
}
@end
