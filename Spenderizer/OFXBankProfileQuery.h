//
//  OFXBankProfileQuery.h
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/11/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "OFXQuery.h"
#import "Bank.h"
#import "BankAccount.h"

@interface OFXBankProfileQuery : OFXQuery
- (id)initWithBank:(Bank *)_bank user:(BankAccount *)_bankAccount;
@end
