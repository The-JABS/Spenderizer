//
//  OFXAccountsRequestQuery.h - Returns all of the users bank accounts, with the
//                              types of OFX functions it supports!! 
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/9/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "OFXSignOnQuery.h"

@interface OFXAccountsRequestQuery : OFXQuery

- (id)initWithBank:(Bank *)_bank user:(BankAccount *)_bankAccount;

@end
