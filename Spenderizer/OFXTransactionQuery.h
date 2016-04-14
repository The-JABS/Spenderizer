//
//  OFXTransactionQuery.h
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/13/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "OFXQuery.h"
#import "BankAccount.h"

@interface OFXTransactionQuery : OFXQuery

- (id)initWithBankAccount:(BankAccount *)account;

@end
