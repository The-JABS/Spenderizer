//
//  TransactionHistory.h
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/25/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Transaction.h"

@interface TransactionHistory : NSObject

@property (nonatomic, retain) NSMutableArray *transactions;

- (void)addTransaction:(Transaction *)_transaction;
- (void)addTransactions:(NSArray *)_transactions;

@end
