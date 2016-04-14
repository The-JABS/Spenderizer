//
//  BankAccount.h
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/5/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bank.h"

@interface BankAccount : NSObject {
    
}

// Constructor
- (id)initWithUserID:(NSString *)userid password:(NSString *)pass accountID:(NSString *)acctID routingNumber:(NSString *)routingNum;
// ******XXXX
- (NSString *)secureID;
// to string
- (NSString *)description;

@property (nonatomic, retain) NSString *userID;           // Bank account username
@property (nonatomic, retain) NSString *password;         // Bank account password
@property (nonatomic, retain) NSString *accountID;        // Bank account ID
@property (nonatomic, retain) NSString *routingNumber;    // Bank account routing number TODO: store in DB?
@property (nonatomic, retain) NSString *status;           // Active or not
@property (nonatomic, retain) NSString *type;             // SAVINGS / CHECKING
@property (nonatomic, retain) NSString *supportTxDl;      // Supports transaction download Y or N
@property (nonatomic, retain) NSString *supportXferDest;  // Supports incoming wire transfers Y or N;
@property (nonatomic, retain) NSString *supportXferSrc;   // Supports out going wire transfers Y or N;
@property (nonatomic, retain) Bank *bank;

@end
