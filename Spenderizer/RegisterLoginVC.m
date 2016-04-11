//
//  RegisterLoginVC.m
//  Spenderizer
//
//  Created by Jackson Foley on 4/6/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "RegisterLoginVC.h"

@interface RegisterLoginVC ()

@end

@implementation RegisterLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if(![defaults boolForKey:@"registered"]){
        NSLog(@"No user registered");
        _loginButton.hidden = YES;
    }
    else {
        NSLog(@"user is registered");
        _confirmPassword.hidden = YES;
        _registerButton.hidden = YES;
    }
            
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)registerUser:(id)sender {
    
    if([_emailAddress.text isEqualToString:@""] || [_passwordField.text isEqualToString: @""] || [_confirmPassword.text isEqualToString:@""]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oooops!"
        message:@"You must enter all fileds." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
        [self checkPasswordMatch];
    }
}

-(void)checkPasswordMatch {
    if([_passwordField.text isEqualToString:_confirmPassword.text]) {
        NSLog(@"passwords match!");
        [self registerNewUser];
    }
    else {
        //NSLog(@"passwords dont match");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Ooops:" message:@"the passwords you entered do not match" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    
    }
    
}

-(void)registerNewUser {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:_emailAddress.text forKey:@"username"];
    [defaults setObject:_passwordField.text forKey:@"password"];
    [defaults setBool:YES forKey:@"registered"];
    
    //[defaults synchronize];
    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Success:" message:@"You have created a Spenderizer account" preferredStyle:UIAlertControllerStyleAlert];
//    
//    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
//    
//    [alert addAction:defaultAction];
//    [self presentViewController:alert animated:YES completion:nil];
    
    [self performSegueWithIdentifier:@"login" sender:self];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
