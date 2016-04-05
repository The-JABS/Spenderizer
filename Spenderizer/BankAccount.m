//
//  BankAccount.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/5/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "BankAccount.h"

@implementation BankAccount
@synthesize userID, password, accountID, routingNumber;

- (id)initWithUserID:(NSString *)userid password:(NSString *)pass accountID:(NSString *)acctID routingNumber:(NSString *)routingNum {
    if (self = [super init]) {
        self.userID = userid;
        self.password = pass;
        self.accountID = acctID;
        self.routingNumber = routingNum;
    }
    return self;
}

@end
