//
//  BankAccountsTableVC.h
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/10/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankAccount.h"
#import "OFXUtil.h"
#import "MCSwipeTableViewCell.h"

@interface BankAccountsTableVC : UITableViewController {

}

@property (retain, nonatomic) NSArray *accounts;

@end
