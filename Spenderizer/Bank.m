//
//  Bank.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/5/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "Bank.h"

@implementation Bank
@synthesize ID, name, fid, org, url;
@synthesize address, city, state, postalCode;

- (id)initWithID:(NSString *)_ID name:(NSString *)_name fid:(NSString *)_fid
             org:(NSString *)_org url:(NSString *)_url {
    if (self = [super init]) {
        // Set the id or make it the empty string (not null).
        _ID ? [self setID:_ID] : [self setID:@""];
        _name ? [self setName:_name] : [self setName:@""];
        _fid ? [self setFid:_fid] : [self setFid:@""];
        _org ? [self setOrg:_org] : [self setOrg:@""];
        _url ? [self setUrl:_url] : [self setUrl:@""];
    }
    return self;
}

@end
