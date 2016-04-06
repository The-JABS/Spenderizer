//
//  SetPinVC.h
//  Spenderizer
//
//  Created by Jackson Foley on 4/6/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABPadLockScreenSetupViewController.h"

@interface SetPinVC : UIViewController<ABPadLockScreenSetupViewControllerDelegate> {
    
}
- (IBAction)setPin:(UIButton *)sender;

@end
