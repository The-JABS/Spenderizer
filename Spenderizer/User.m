//
//  User.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/4/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize userID, accountID, routingNumber, password, name;

- (id)initWithUserID:(NSString *)_userID accountID:(NSString *)_accountID
       routingNumber:(NSString *)_routingNumber password:(NSString *)_password {
    if (self = [super init]) {
        self.userID = _userID;
        self.accountID = _accountID;
        self.routingNumber = _routingNumber;
        self.password = _password;
    }
    return self;
}

- (void)clearPassword {
    self.password = NULL;
}

- (NSString *)bankID {
    return self.routingNumber;
}

@end
