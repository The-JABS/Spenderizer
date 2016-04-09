//
//  BankSignInFormVC.h
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/8/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MetaBankInfo.h"

@interface BankSignInFormVC : UIViewController<UITextFieldDelegate> {

}
@property (weak, nonatomic) IBOutlet UITextField *userIDField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UILabel *bankNameLb;

@property (nonatomic, retain) MetaBankInfo *bankInfo;

- (void)setBankInfo:(MetaBankInfo *)_bankInfo;

@end
