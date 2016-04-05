//
//  BankAccount.h
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/5/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankAccount : NSObject {
    
}

// Constructor
- (id)initWithUserID:(NSString *)userid password:(NSString *)pass accountID:(NSString *)acctID routingNumber:(NSString *)routingNum;

@property (nonatomic, retain) NSString *userID;           // Bank account username
@property (nonatomic, retain) NSString *password;         // Bank account password
@property (nonatomic, retain) NSString *accountID;        // Bank account ID
@property (nonatomic, retain) NSString *routingNumber;    // Bank account routing number TODO: store in DB?

@end
