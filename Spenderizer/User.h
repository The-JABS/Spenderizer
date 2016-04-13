//
//  User.h - Represents a user in the Spenderizer system.
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/5/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BankAccount.h"
#import "KeychainWrapper.h"

@interface User : NSObject {
    NSMutableArray *bankAccounts;  // Bank accounts that the user has added.
}

+ (User *)sharedInstance;                         // Singleton method

- (void)addBankAccount:(BankAccount *)bankAcct;   // Ability to add a new bank account
- (void)removeBankAccount:(BankAccount *)bankAcct;

@property (nonatomic, retain) NSString *name;     // Spenderizer username
@property (nonatomic, retain) NSString *password; // Spenderizer password

@end
