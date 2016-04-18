//
//  BankAccount.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/5/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "BankAccount.h"

@implementation BankAccount
@synthesize userID, password, accountID, routingNumber, type, status;
@synthesize supportTxDl, supportXferSrc, supportXferDest;
@synthesize bank;

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
    return [self.accountID isEqualToString:object.accountID] && [self.routingNumber isEqualToString:object.routingNumber];
}

- (NSString *)description {
    return [NSString stringWithFormat: @"Bank-Account: userID=%@ accountID=%@ routing=%@ type=%@ supportTxDL=%@ supXferSrc=%@ supXferDest=%@", userID, accountID,routingNumber, type, supportTxDl, supportXferSrc, supportXferDest];
}

// Encode an object for an archive
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:userID          forKey:@"userID"];
    [coder encodeObject:password        forKey:@"password"];
    [coder encodeObject:accountID       forKey:@"accountID"];
    [coder encodeObject:routingNumber   forKey:@"routingNumber"];
    [coder encodeObject:status          forKey:@"status"];
    [coder encodeObject:type            forKey:@"type"];
    [coder encodeObject:supportTxDl     forKey:@"supportTxDl"];
    [coder encodeObject:supportXferDest forKey:@"supportXferDest"];
    [coder encodeObject:supportXferSrc  forKey:@"supportXferSrc"];
    [coder encodeObject:bank            forKey:@"bank"];
    
}
// Decode an object from an archive
- (id)initWithCoder:(NSCoder *)coder {
    if (self = [self init]) {
        userID          = [coder decodeObjectForKey:@"userID"];
        password        = [coder decodeObjectForKey:@"password"];
        accountID       = [coder decodeObjectForKey:@"accountID"];
        routingNumber   = [coder decodeObjectForKey:@"routingNumber"];
        status          = [coder decodeObjectForKey:@"status"];
        type            = [coder decodeObjectForKey:@"type"];
        supportTxDl     = [coder decodeObjectForKey:@"supportTxDl"];
        supportXferDest = [coder decodeObjectForKey:@"supportXferDest"];
        supportXferSrc  = [coder decodeObjectForKey:@"supportXferSrc"];
        bank            = [coder decodeObjectForKey:@"bank"];
    }
    return self;
}

@end
