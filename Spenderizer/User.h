//
//  User.h - Represents a user in the Spenderizer system.
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/5/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BankAccount.h"

@interface User : NSObject {
    NSMutableArray *bankAccounts;
    
}

- (id)initWithName:(NSString *)_name password:(NSString *)_password;

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *password;

@end
