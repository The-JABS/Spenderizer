//
//  BankAccount.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/5/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "BankAccount.h"
#import "AppDelegate.h"

@implementation BankAccount
@synthesize userID, password, accountID, routingNumber, type, status;
@synthesize supportTxDl, supportXferSrc, supportXferDest;
@synthesize bank, transactions;

- (id)initWithUserID:(NSString *)userid password:(NSString *)pass accountID:(NSString *)acctID routingNumber:(NSString *)routingNum {
    if (self = [super init]) {
        self.userID = userid;
        self.password = pass;
        self.accountID = acctID;
        self.routingNumber = routingNum;
        
        [self loadAllTransactions];
        
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



#pragma mark - Transaction History

- (BOOL)containsTransaction:(Transaction *)target {
    for (Transaction *t in transactions) {
        if ([t isEqual:target]) {
            return YES;
        }
    }
    return NO;
}

- (void)addTransactionObject:(Transaction *)value {
    if (![self containsTransaction:value]) {
        [transactions addObject:value];
       [self saveTransactions];
    }
}

- (void)addTransactions:(NSArray *)values {
    for (Transaction *value in values) {
       if (![self containsTransaction:value]) {
           [transactions addObject:value];
       }
    }
    [self saveTransactions];
}

- (NSString *)accountKey {
    return [NSString stringWithFormat:@"%@", accountID];
}

- (void)saveTransactions {
    // Get the context for the Core Data
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    // Create a fetch request for all the transaction managed objects
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CoreTransaction"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;

    // Store all fetched managed objects
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];

    // Check if each transaction is already in db
    for (Transaction *t in transactions) {
       
        // Get the index of the transaction t in the fetched managed objects OR -1 (not found)
        NSInteger index = [self indexOfobjectIn:fetchedObjects contains:t];
        
        NSManagedObject *transactionObject = nil;
        
        // Check if we need to update or make a new managed transaction object.
        if (index != -1) {
            //update
            transactionObject = [fetchedObjects objectAtIndex:index];
            
        } else {
            // Create new
            transactionObject = [NSEntityDescription
                                                  insertNewObjectForEntityForName:@"CoreTransaction"
                                                  inManagedObjectContext:context];
        }
        
        // Update or Set all of the values
        [transactionObject setValue:[NSNumber numberWithFloat:t.amt] forKey:@"amt"];
        [transactionObject setValue:t.datePosted forKey:@"datePosted"];
        [transactionObject setValue:t.FITID forKey:@"fitID"];
        [transactionObject setValue:t.memo forKey:@"memo"];
        [transactionObject setValue:t.name forKey:@"name"];
        [transactionObject setValue:t.type forKey:@"type"];
        //NSData *catData = [NSKeyedArchiver archivedDataWithRootObject:t.category];
        [transactionObject setValue:t.category forKey:@"category"];
        [transactionObject setValue:[self accountKey] forKey:@"account"];
        
        
        // Save!
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }

    }
    
//    NSData *encodedTransactions = [NSKeyedArchiver archivedDataWithRootObject:transactions];
//    [[NSUserDefaults standardUserDefaults] setObject:encodedTransactions forKey:[self accountKey]];
}

- (NSInteger)indexOfobjectIn:(NSArray *)array contains:(Transaction *)t {
    
    for (NSInteger i = 0; i < array.count; i++) {
        NSManagedObject *object = [array objectAtIndex:i];
        if ([[object valueForKey:@"fitID"] isEqualToString:t.FITID]) {
            return i;
        }
    }
    return -1;
}

- (NSData *)loadTransactions {
    return [[NSUserDefaults standardUserDefaults] objectForKey:[self accountKey]];
}

- (void)loadAllTransactions {
    // Create a new transactions array
    if (transactions) {
        [transactions removeAllObjects];
    } else {
        transactions = [[NSMutableArray alloc] init];
    }
    
    // Get the context for core data
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    // Request all transactions in local db
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"CoreTransaction"];
    // Get a copy of all managed objects in transaction table
    NSArray *fetchedObjects = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    // Convert managed objects to Transaction objects
    for (NSManagedObject *mo in fetchedObjects) {
        if ([[mo valueForKey:@"account"] isEqualToString:[self accountKey]]) {
            Transaction *t = [[Transaction alloc] init];
            [t setAmt:[[mo valueForKey:@"amt"] floatValue]];
            [t setDatePosted:[mo valueForKey:@"datePosted"]];
            [t setFITID:[mo valueForKey:@"fitID"]];
            [t setMemo:[mo valueForKey:@"memo"]];
            [t setName:[mo valueForKey:@"name"]];
            [t setType:[mo valueForKey:@"type"]];
            [t setCategory:[mo valueForKey:@"category"]];
        
            [transactions addObject:t];
        }
        
    }
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
    [coder encodeObject:transactions    forKey:@"transactions"];
    
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
        transactions    = [coder decodeObjectForKey:@"transactions"];
    }
    return self;
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

@end
