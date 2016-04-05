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

- (id)initWithName:(NSString *)_name password:(NSString *)_password {
    if (self = [super init]) {
        self.name = _name;
        self.password = _password;
        bankAccounts = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addBankAccount:(BankAccount *)bankAcct {
    [bankAccounts addObject:bankAcct];
}

@end
