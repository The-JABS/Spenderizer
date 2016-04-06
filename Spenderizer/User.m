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

/**
 * Constructor
 * @param name - Spenderizer username
 * @param password - Spenderizer password
 */
- (id)initWithName:(NSString *)_name password:(NSString *)_password {
    if (self = [super init]) {
        self.name = _name;
        self.password = _password;
        bankAccounts = [[NSMutableArray alloc] init];
    }
    return self;
}

/** Adds a BankAccount object to the usersList of bankAccounts
 * @param Bank Account
 */
- (void)addBankAccount:(BankAccount *)bankAcct {
    [bankAccounts addObject:bankAcct];
}

@end
