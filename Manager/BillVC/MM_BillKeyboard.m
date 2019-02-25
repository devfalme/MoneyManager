//
//  MM_BillKeyboard.m
//  Manager
//
//  Created by devfalme on 2018/12/17.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_BillKeyboard.h"

@interface MM_BillKeyboard ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tagImageView;
@property (weak, nonatomic) IBOutlet UITextField *remarkTextField;

@property (weak, nonatomic) IBOutlet UIButton *equalButton;

@property (nonatomic, retain) NSMutableString *titleString;

@property (nonatomic, retain) NSMutableString *currentString;

@property (nonatomic, retain) NSMutableArray *formulaArr;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;

@property (nonatomic, copy) void(^date)(void);
@property (nonatomic, copy) void(^action)(NSString *remark, NSNumber *price);
@end

@implementation MM_BillKeyboard
- (void)imageName:(NSString *)imageName {
    self.tagImageView.image = [UIImage imageNamed:imageName];
}

- (void)date:(NSString *)date {
    [self.dateButton setTitle:date forState:UIControlStateNormal];
}

- (void)placehold:(NSString *)placehold {
    self.remarkTextField.placeholder = placehold;
}

- (void)reload {
    self.titleString = [@"0" mutableCopy];
    self.contentLabel.text = self.titleString;
    self.currentString = [@"0" mutableCopy];
    self.remarkTextField.text = @"";
    self.formulaArr = [NSMutableArray array];
}

+ (instancetype)date:(void(^)(void))date action:(void(^)(NSString *remark, NSNumber *price))action {
    MM_BillKeyboard *view = [self loadFromNib];
    view.date = date;
    view.action = action;
    return view;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleString = [@"0" mutableCopy];
    self.currentString = [@"0" mutableCopy];
    self.formulaArr = [NSMutableArray array];
}

- (IBAction)timeButtonAction:(id)sender {
    self.date();
}

- (IBAction)nineButtonAction:(id)sender {
    if ([self.titleString isEqualToString:@"0"]) {
        self.titleString = [@"9" mutableCopy];
        self.currentString = [@"9" mutableCopy];
    }else{
        [self.titleString appendString:@"9"];
        [self.currentString appendString:@"9"];
    }
    
    self.contentLabel.text = self.titleString;
}

- (IBAction)eightButtonAction:(id)sender {
    if ([self.titleString isEqualToString:@"0"]) {
        self.titleString = [@"8" mutableCopy];
        self.currentString = [@"8" mutableCopy];
    }else{
        [self.titleString appendString:@"8"];
        [self.currentString appendString:@"8"];
    }
    
    self.contentLabel.text = self.titleString;
}

- (IBAction)sevenButtonAction:(id)sender {
    if ([self.titleString isEqualToString:@"0"]) {
        self.titleString = [@"7" mutableCopy];
        self.currentString = [@"7" mutableCopy];
    }else{
        [self.titleString appendString:@"7"];
        [self.currentString appendString:@"7"];
    }
    
    self.contentLabel.text = self.titleString;
}

- (IBAction)plusButtonAction:(id)sender {
    
    if (self.currentString.length) {
        [self.titleString appendString:@"+"];
        [self.formulaArr addObject:self.currentString];
        [self.formulaArr addObject:[@"+" mutableCopy]];
        self.currentString = [@"" mutableCopy];
    }
    
    if (self.formulaArr.count > 1) {
        [self.equalButton setImage:[UIImage imageNamed:@"Equal"] forState:UIControlStateNormal];
    }
    
    self.contentLabel.text = self.titleString;
}

- (IBAction)sixButtonAction:(id)sender {
    if ([self.titleString isEqualToString:@"0"]) {
        self.titleString = [@"6" mutableCopy];
        self.currentString = [@"6" mutableCopy];
    }else{
        [self.titleString appendString:@"6"];
        [self.currentString appendString:@"6"];
    }
    
    self.contentLabel.text = self.titleString;
}

- (IBAction)fiveButtonAction:(id)sender {
    if ([self.titleString isEqualToString:@"0"]) {
        self.titleString = [@"5" mutableCopy];
        self.currentString = [@"5" mutableCopy];
    }else{
        [self.titleString appendString:@"5"];
        [self.currentString appendString:@"5"];
    }
    
    self.contentLabel.text = self.titleString;
}

- (IBAction)fourButtonAction:(id)sender {
    if ([self.titleString isEqualToString:@"0"]) {
        self.titleString = [@"4" mutableCopy];
        self.currentString = [@"4" mutableCopy];
    }else{
        [self.titleString appendString:@"4"];
        [self.currentString appendString:@"4"];
    }
    
    self.contentLabel.text = self.titleString;
}

- (IBAction)minusButtonAction:(id)sender {
    if (self.currentString.length) {
        [self.titleString appendString:@"-"];
        [self.formulaArr addObject:self.currentString];
        [self.formulaArr addObject:[@"-" mutableCopy]];
        self.currentString = [@"" mutableCopy];
    }
    
    if (self.formulaArr.count > 1) {
        [self.equalButton setImage:[UIImage imageNamed:@"Equal"] forState:UIControlStateNormal];
    }
    
    self.contentLabel.text = self.titleString;
}

- (IBAction)threeButtonAction:(id)sender {
    if ([self.titleString isEqualToString:@"0"]) {
        self.titleString = [@"3" mutableCopy];
        self.currentString = [@"3" mutableCopy];
    }else{
        [self.titleString appendString:@"3"];
        [self.currentString appendString:@"3"];
    }
    
    self.contentLabel.text = self.titleString;
}

- (IBAction)twoButtonAction:(id)sender {
    if ([self.titleString isEqualToString:@"0"]) {
        self.titleString = [@"2" mutableCopy];
        self.currentString = [@"2" mutableCopy];
    }else{
        [self.titleString appendString:@"2"];
        [self.currentString appendString:@"2"];
    }
    
    self.contentLabel.text = self.titleString;
}

- (IBAction)oneButtonAction:(id)sender {
    if ([self.titleString isEqualToString:@"0"]) {
        self.titleString = [@"1" mutableCopy];
        self.currentString = [@"1" mutableCopy];
    }else{
        [self.titleString appendString:@"1"];
        [self.currentString appendString:@"1"];
    }
    
    self.contentLabel.text = self.titleString;
}

- (IBAction)equalButtonAction:(id)sender {
   
    if (self.formulaArr.count > 1) {
        if (self.currentString.length) {
            [self.formulaArr addObject:self.currentString];
        }else{
            [self.formulaArr addObject:@"0"];
        }
        double totol = 0;
        BOOL isPlus = YES;
        for (NSString *count in self.formulaArr) {
            if ([count isEqualToString:@"+"]) {
                isPlus = YES;
                continue;
            }
            if ([count isEqualToString:@"-"]) {
                isPlus = NO;
                continue;
            }
            
            totol += isPlus? [count doubleValue] : -[count doubleValue];
        }
        self.currentString = [@(totol).stringValue mutableCopy];
        self.titleString = [@(totol).stringValue mutableCopy];
        [self.formulaArr removeAllObjects];
        self.contentLabel.text = self.titleString;
        [self.equalButton setImage:[UIImage imageNamed:@"Done"] forState:UIControlStateNormal];
    }else{
        if ([self.titleString doubleValue] > 0) {
            NSString *remark = self.remarkTextField.text.length ? self.remarkTextField.text: self.remarkTextField.placeholder;
            self.action(remark, @([self.titleString doubleValue]));
        }
    }
}

- (IBAction)deleteButtonAction:(id)sender {
    NSString *lastChar = [self.titleString substringWithRange:NSMakeRange(self.titleString.length-1, 1)];
    if ([lastChar isEqualToString:@"-"] || [lastChar isEqualToString:@"+"]) {
        [self.titleString deleteCharactersInRange:NSMakeRange(self.titleString.length-1, 1)];
        [self.formulaArr removeLastObject];
        self.currentString = [self.formulaArr lastObject];
        [self.formulaArr removeLastObject];
    }else{
        [self.titleString deleteCharactersInRange:NSMakeRange(self.titleString.length-1, 1)];
        [self.currentString deleteCharactersInRange:NSMakeRange(self.currentString.length-1, 1)];
        if (self.titleString.length == 0) {
            [self.titleString appendString:@"0"];
            [self.currentString appendString:@"0"];
        }
    }
    
    if (self.formulaArr.count <= 1) {
        [self.equalButton setImage:[UIImage imageNamed:@"Done"] forState:UIControlStateNormal];
    }
    
    
    self.contentLabel.text = self.titleString;
}

- (IBAction)zeroButtonAction:(id)sender {
    if (![self.currentString isEqualToString:@"0"]) {
        [self.titleString appendString:@"0"];
        [self.currentString appendString:@"0"];
    }
    
    self.contentLabel.text = self.titleString;
}

- (IBAction)pointButtonAction:(id)sender {
    if (![self.currentString containsString:@"."]) {
        if (!self.currentString.length) {
            [self.titleString appendString:@"0"];
            [self.currentString appendString:@"0"];
        }
        [self.titleString appendString:@"."];
        [self.currentString appendString:@"."];
    }
    
    self.contentLabel.text = self.titleString;
}

@end
