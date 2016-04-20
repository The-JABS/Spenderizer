//
//  TransactionTableVC.h
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/12/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OFXget.h"
#import "SGMLParser.h"
#import "OFXTransactionQuery.h"
#import "Transaction.h"
#import "BankAccount.h"
#import "TransactionTableViewCell.h"
#import "MBProgressHUD.h"

@interface TransactionTableVC : UITableViewController <OFXGetDelegate> {
    NSMutableArray *transactions;
    BankAccount *userAccount;
}

- (void)setAccount:(BankAccount *)bankAccount;

@end
