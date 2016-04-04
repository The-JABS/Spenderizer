//
//  Bank.h
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/4/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bank : NSObject
- (id)initWithID:(NSString *)_ID name:(NSString *)_name fid:(NSString *)_fid
             org:(NSString *)_org url:(NSString *)_url brokerID:(NSString *)_brokerID;

@property (nonatomic, retain) NSString *ID;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *fid;
@property (nonatomic, retain) NSString *org;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *brokerID;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *postalCode;
@end
