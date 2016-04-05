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

- (id)initWithUserID:(NSString *)userid password:(NSString *)pass accountID:(NSString *)acctID routingNumber:(NSString *)routingNum;

@property (nonatomic, retain) NSString *userID;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *accountID;
@property (nonatomic, retain) NSString *routingNumber;

@end
