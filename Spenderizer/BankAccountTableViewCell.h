//
//  BankAccountTableViewCell.h
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/12/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankAccount.h"
#import "User.h"

@interface BankAccountTableViewCell : UITableViewCell {
    BOOL isLinked;
}

@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UIButton *linkBt;
@property (nonatomic, retain) BankAccount *account;

- (IBAction)toggleLink:(UIButton *)sender;
@end
