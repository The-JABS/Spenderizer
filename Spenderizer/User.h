//
//  User.h - Represents a user in the Spenderizer system.
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/5/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BankAccount.h"

@interface User : NSObject {
    
}

/// Spenderizer username
@property (nonatomic, retain) NSString *name;
// Spenderizer password
@property (nonatomic, retain) NSString *password;
// Bank accounts that the user has added.
@property (nonatomic, retain) NSMutableArray *bankAccounts;

/** Singleton method to get the shared static
    instance of User.
 */
+ (User *)sharedInstance;


/** Adds a BankAccount object to the usersList of bankAccounts
 * @param Bank Account
 */
- (void)addBankAccount:(BankAccount *)bankAcct;


/** Removes the bankAccount with the same accountID and routing number.
 * @param Bank Account
 */
- (void)removeBankAccount:(BankAccount *)bankAcct;


/** Gets all the unique banks that the user has.
 * @return an Array of banks that the user has accounts with.
 */
- (NSArray *)uniqueBanks;


/** Gives array of all the accounts for a given bank.
 *
 */
- (NSArray *)accountsForBank:(Bank *)bank;

- (void)removeAccountsForBank:(Bank *)bank;

@end
