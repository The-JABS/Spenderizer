//
//  User.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/5/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize name, password;

// Singleton pattern for User.
+ (User *)sharedInstance {
    static User *instance;
    
    @synchronized(self) {
        if (!instance) {
            instance = [[User alloc] init];
        }
    }
    
    return instance;
}


/**
 * Constructor
 * @param name - Spenderizer username
 * @param password - Spenderizer password
 */
- (id)init {
    if (self = [super init]) {
        self.name = @"";
        self.password = @"";
        bankAccounts = [[NSMutableArray alloc] init];
    }
    return self;
}

/** Adds a BankAccount object to the usersList of bankAccounts
 * @param Bank Account
 */
- (void)addBankAccount:(BankAccount *)bankAcct {
    [bankAccounts addObject:bankAcct];
    NSLog(@"%lu", (unsigned long)[bankAccounts count]);
}

- (void)removeBankAccount:(BankAccount *)bankAcct {
    BankAccount *toRemove = bankAcct;
    for (BankAccount *account in bankAccounts) {
        if ([account isEqual:bankAcct]) {
            toRemove = account;
        }
    }
    [bankAccounts removeObject:toRemove];
    NSLog(@"%lu", (unsigned long)[bankAccounts count]);
}

- (void)saveAccounts {
   
}

@end
