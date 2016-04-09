//
//  BankSignInFormVC.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/8/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "BankSignInFormVC.h"

@interface BankSignInFormVC ()

@end

@implementation BankSignInFormVC
@synthesize userIDField, passwordField, bankNameLb, bankInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Bank Sign In"];
    [bankNameLb setText:[bankInfo name]];
    [userIDField setDelegate:self];
    [passwordField setDelegate:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == userIDField) {
        [textField resignFirstResponder];
        [passwordField becomeFirstResponder];
    } else if (textField == passwordField) {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"this was called");
}


@end
