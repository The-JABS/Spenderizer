//
//  TransactionHistory.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/25/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "TransactionHistory.h"

@implementation TransactionHistory
@synthesize transactions;



- (id)init {
    if (self = [super init]) {
        transactions = [NSMutableArray new];
        NSData *encodedSelf = [self load];
        if (encodedSelf) {
            self = [NSKeyedUnarchiver unarchiveObjectWithData:encodedSelf];
        }
    }
    return self;
}

- (void)addTransaction:(Transaction *)_transaction {
    [transactions addObject:_transaction];
}

- (void)addTransactions:(NSArray *)_transactions {
    [transactions addObjectsFromArray:_transactions];
}

- (void)save {
    NSData *encodedSelf = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:encodedSelf forKey:TRANSACTION_HISTORY_KEY];
}

- (NSData *)load {
    return [[NSUserDefaults standardUserDefaults] objectForKey:TRANSACTION_HISTORY_KEY];
    
}


@end
