//
//  User.h
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/4/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
- (id)initWithUserID:(NSString *)_userID accountID:(NSString *)_accountID
       routingNumber:(NSString *)_routingNumber password:(NSString *)_password;
- (void)clearPassword;
- (NSString *)bankID;

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *userID;
@property (nonatomic, retain) NSString *accountID;
@property (nonatomic, retain) NSString *routingNumber;
@property (nonatomic, retain) NSString *password;
@end
