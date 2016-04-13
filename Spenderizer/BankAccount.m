//
//  BankAccount.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/5/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "BankAccount.h"

@implementation BankAccount
@synthesize userID, password, accountID, routingNumber, type;
@synthesize supportTxDl, supportXferSrc, supportXferDest;

/** Constructor
 * @param userID
 * @param password
 * @param accountID
 * @param routingNumber
 */
- (id)initWithUserID:(NSString *)userid password:(NSString *)pass accountID:(NSString *)acctID routingNumber:(NSString *)routingNum {
    if (self = [super init]) {
        self.userID = userid;
        self.password = pass;
        self.accountID = acctID;
        self.routingNumber = routingNum;
    }
    return self;
}

- (NSString *)secureID {
    NSInteger numberOfStars = accountID.length-4;
    NSMutableString *stars = [NSMutableString string];
    for (NSInteger i = 0; i <  numberOfStars; i++) {
        [stars appendString:@"*"];
    }
    return [NSString stringWithFormat:@"%@%@", stars, [accountID substringFromIndex:accountID.length-4]];
}

- (BOOL)isEqual:(BankAccount *)object {
    return self.accountID == object.accountID && self.routingNumber == object.routingNumber;
}

- (NSString *)description {
    return [NSString stringWithFormat: @"Bank-Account: userID=%@ accountID=%@ routing=%@ type=%@ supportTxDL=%@ supXferSrc=%@ supXferDest=%@", userID, accountID,routingNumber, type, supportTxDl, supportXferSrc, supportXferDest];
}

@end
