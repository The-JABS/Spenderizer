//
//  Loader.h - This is a simple class that contains static methods used
//             to download data.
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/5/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLParser.h"
#import "MetaBankInfo.h"
#import "Bank.h"

@interface Loader : NSObject

+ (NSMutableArray *)downloadMetaBankInfo;
+ (Bank *)loadBankWithID:(NSString *)_ID andRoutingNumber:(NSString *)_routingNumber;

@end
