//
//  SetPinVC.m
//  Spenderizer
//
//  Created by Jackson Foley on 4/6/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "SetPinVC.h"

@interface SetPinVC ()

@end

@implementation SetPinVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)setPin:(UIButton *)sender {
    ABPadLockScreenSetupViewController *lockScreen = [[ABPadLockScreenSetupViewController alloc] initWithDelegate:self complexPin:false];
    [lockScreen setErrorVibrateEnabled:true];
    [lockScreen setCancelButtonText:@"cancel"];
    lockScreen.modalPresentationStyle = UIModalPresentationFullScreen;
    lockScreen.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:lockScreen animated:YES completion:nil];

}

- (void)pinSet:(NSString *)pin padLockScreenSetupViewController:(ABPadLockScreenSetupViewController *)padLockScreenViewController {
    [padLockScreenViewController dismissViewControllerAnimated:YES completion:^{
        NSLog(@"user is done");
    }];
    NSLog(@"The user wants this %@", pin);
    
}

- (void)unlockWasCancelledForPadLockScreenViewController:(ABPadLockScreenAbstractViewController *)padLockScreenViewController {
    
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = tableView.tintColor;
    
    //    // if you have index/header text in your tableview change your index text color
    //    UITableViewHeaderFooterView *headerIndexText = (UITableViewHeaderFooterView *)view;
    //    [headerIndexText.textLabel setTextColor:[UIColor blackColor]];
    
}
@end
