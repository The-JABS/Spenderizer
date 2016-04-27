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
#import "NSMutableArray+SWUtilityButtons.h"
#import "SWTableViewCell.h"

@interface TransactionTableVC : UITableViewController <OFXGetDelegate, SWTableViewCellDelegate> {
    BankAccount *userAccount;
}

- (void)setAccount:(BankAccount *)bankAccount;


@end
