//
//  OFXAccountsRequestQuery.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/9/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "OFXAccountsRequestQuery.h"

@implementation OFXAccountsRequestQuery

- (id)initWithBank:(Bank *)_bank user:(BankAccount *)_bankAccount {
    if (self = [super init]) {
        [self.body setString:[OFXUtil loadQueryFromFile:@"OFXAccountsRequestTemplate"]];
        
        // Sign on
        [self replace:@"{DTCLIENT}" with:[OFXUtil getDate]];
        [self replace:@"{USERID}" with:[_bankAccount userID]];
        [self replace:@"{USERPASS}" with:[_bankAccount password]];
        [self replace:@"{LANGUAGE}" with:@"ENG"];
        [self replace:@"{ORG}" with:[_bank org]];
        [self replace:@"{FID}" with:[_bank fid]];
        [self replace:@"{APPID}" with:@"QWIN"];
        [self replace:@"{APPVER}" with:@"2200"];
        [self replace:@"{CLIENTUID}" with:[OFXUtil getClientID]];
        
        // Sign up
        // Last time that the client updated (we just say a long time ago so that it will give us new info!)
        [self replace:@"{DTACCTUP}" with:[OFXUtil getOldDate]];
        [self replace:@"{TRNUID}" with:@"1001"];
    }
    return self;
}


@end
