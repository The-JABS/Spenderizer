//
//  RegisterLoginVC.h
//  Spenderizer
//
//  Created by Jackson Foley on 4/6/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterLoginVC : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *emailAddress;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;


-(IBAction)registerUser:(id)sender;
-(IBAction)loginUser:(id)sender;

@end
