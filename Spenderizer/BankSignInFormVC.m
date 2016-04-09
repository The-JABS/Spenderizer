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
    // Set the title of the nav bar
    [self.navigationItem setTitle:@"Bank Sign In"];
    
    // Add submit form button that calls signIn method
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign In" style:UIBarButtonItemStylePlain target:self action:@selector(signIn:)];
    
    // Set the text of the bank label
    [bankNameLb setText:[bankInfo name]];
    
    // Listen for next/done button of textfields
    [userIDField setDelegate:self];
    [passwordField setDelegate:self];
    
    // Dismiss keyboard on tap of background
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    // Create an OFXget object to make sign in query
    ofxGet = [[OFXget alloc] init];
    [ofxGet setDelegate:self];
    
}

- (IBAction)signIn:(UIButton *)sender {
    if([self isValid]) {
        [self dismissKeyboard];
        Bank *userBank = [Loader loadBankWithID:bankInfo.ID andRoutingNumber:@""];
        BankAccount *userBankAcct = [[BankAccount alloc] initWithUserID:userIDField.text password:passwordField.text accountID:@"" routingNumber:@""];
        OFXSignOnQuery *signOnQry = [[OFXSignOnQuery alloc] initWithBank:userBank user:userBankAcct];
        [ofxGet query:signOnQry server:[userBank url]];
    }
}

// Validate input
- (bool)isValid {
    bool valid = true;
    if (userIDField.text.length <= 0) {
        valid = false;
        [self displayErrorMessage:@"User ID is a required field."];
    } else if (passwordField.text.length <= 0) {
        valid = false;
        [self displayErrorMessage:@"Password is a required field."];
    }
    return valid;
}

// Display alert with error msg
- (void)displayErrorMessage:(NSString *)msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

// Called when user pressed next/done on keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == userIDField) {
        [textField resignFirstResponder];
        [passwordField becomeFirstResponder];
    } else if (textField == passwordField) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)dismissKeyboard {
    [userIDField resignFirstResponder];
    [passwordField resignFirstResponder];
}

#pragma mark - OFXGetDelegate
- (void)didFinishDownloading:(NSString *)result {
    NSLog(@"result");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"this was called");
}


@end
