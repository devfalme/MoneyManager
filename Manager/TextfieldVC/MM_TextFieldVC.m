//
//  MM_TextFieldVC.m
//  Calculator
//
//  Created by devfalme on 2018/12/12.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "MM_TextFieldVC.h"

@interface MM_TextFieldVC ()
@property (nonatomic, copy) NSString *placehold;
@property (nonatomic, copy) NSNumber *type;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic, copy) void(^confirmAction)(NSString *);
@end

@implementation MM_TextFieldVC

ROUTER_PATH(@"TextFieldVC")


- (IBAction)confirmButtonAction:(id)sender {
    if (self.textField.text.length) {
        self.confirmAction(self.textField.text);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.textField.keyboardType = self.type.integerValue;
    self.textField.placeholder = self.placehold;

//    [self.textField becomeFirstResponder];
}


@end
