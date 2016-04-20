//
//  OFXTransactionQuery.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/13/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "OFXTransactionQuery.h"

@implementation OFXTransactionQuery

- (id)initWithBankAccount:(BankAccount *)account {
    if (self = [super init]) {
        [self.body setString:[OFXUtil loadQueryFromFile:@"OFXTransactionTemplate"]];
        
        [self replace:@"{DTCLIENT}" with:[OFXUtil getDate]];
        [self replace:@"{USERID}" with:[account userID]];
        [self replace:@"{USERPASS}" with:[account password]];
        [self replace:@"{LANGUAGE}" with:@"ENG"];
        [self replace:@"{ORG}" with:[account.bank org]];
        [self replace:@"{FID}" with:[account.bank fid]];
        [self replace:@"{APPID}" with:OFX_APP_ID];
        [self replace:@"{APPVER}" with:OFX_APP_VERSION];
        
        [self replace:@"{TRNUID}" with:[OFXUtil getTRNUID]];
        [self replace:@"{BANKID}" with:[account routingNumber]];
        [self replace:@"{ACCTID}" with:[account accountID]];
        [self replace:@"{ACCTTYPE}" with:[account type]];
        
    }
    return self;
}

@end
