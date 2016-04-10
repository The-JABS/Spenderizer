//
//  OFXSignOnQuery.h
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/8/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OFXQuery.h"
#import "Bank.h"
#import "User.h"

@interface OFXSignOnQuery : OFXQuery

- (id)initWithBank:(Bank *)_bank user:(BankAccount *)_bankAccount;

@end
