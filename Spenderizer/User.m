//
//  User.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/5/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "User.h"
#import "FXKeychain.h"

@implementation User
@synthesize name, password, bankAccounts;

+ (User *)sharedInstance {
    static User *instance;
    @synchronized(self) {
        if (!instance) {
            instance = [[User alloc] init];
        }
    }
    return instance;
}

- (id)init {
    if (self = [super init]) {
        self.name = @"";
        self.password = @"";
        bankAccounts = [[NSMutableArray alloc] init];
        
        NSData *encodedSelf = [[FXKeychain defaultKeychain] objectForKey:@"self"];
        if (encodedSelf) {
            self = [NSKeyedUnarchiver unarchiveObjectWithData:encodedSelf];
        }
        
    }
    return self;
}

- (void)addBankAccount:(BankAccount *)bankAcct {
    if (![self containsAccount:bankAcct]) {
        [bankAccounts addObject:bankAcct];
    }
    NSLog(@"%lu", (unsigned long)[bankAccounts count]);
    [self save];
}

- (BOOL)containsAccount:(BankAccount *)bankAcct {
    BOOL result = false;
    for (BankAccount *acct in bankAccounts) {
        if ([acct isEqual:bankAcct]) {
            result = true;
        }
    }
    return result;
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
    [self save];
}

- (NSArray *)uniqueBanks {
    NSMutableSet *bankSet = [[NSMutableSet alloc] init];
    for (BankAccount *account in bankAccounts) {
        if (account.bank)
            [bankSet addObject:account.bank];
    }
    return [bankSet allObjects];
}

- (NSArray *)accountsForBank:(Bank *)bank {
    NSMutableArray *accounts = [NSMutableArray array];
    for (BankAccount *account in bankAccounts) {
        if ([account.bank isEqual:bank])
            [accounts addObject:account];
    }
    return accounts;
}

- (void)removeAccountsForBank:(Bank *)bank {
    NSMutableArray *toRemove = [NSMutableArray array];
    for (BankAccount *account in bankAccounts) {
        if ([account.bank isEqual:bank])
            [toRemove addObject:account];
    }
    [bankAccounts removeObjectsInArray:toRemove];
    
    [self save];
}

- (void)save {
    NSData *encodedSelf = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[FXKeychain defaultKeychain] setObject:encodedSelf forKey:@"self"];
}

// Encode an object for an archive
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:name forKey:@"name"];
    [coder encodeObject:password forKey:@"password"];
    [coder encodeObject:bankAccounts forKey:@"bankAccounts"];
    
}
// Decode an object from an archive
- (id)initWithCoder:(NSCoder *)coder
{
    if (self = [super init]) {
        name = [coder decodeObjectForKey:@"name"];
        password = [coder decodeObjectForKey:@"password"];
        bankAccounts = [coder decodeObjectForKey:@"bankAccounts"];
    }
    return self;
}

@end
