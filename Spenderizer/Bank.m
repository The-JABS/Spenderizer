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

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:ID forKey:@"ID"];
    [coder encodeObject:name forKey:@"name"];
    [coder encodeObject:fid forKey:@"fid"];
    [coder encodeObject:org forKey:@"org"];
    [coder encodeObject:url forKey:@"url"];
    [coder encodeObject:address forKey:@"address"];
    [coder encodeObject:city forKey:@"city"];
    [coder encodeObject:state forKey:@"state"];
    [coder encodeObject:postalCode forKey:@"postalCode"];
}

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        ID      = [coder decodeObjectForKey:@"ID"];
        name    = [coder decodeObjectForKey:@"name"];
        fid     = [coder decodeObjectForKey:@"fid"];
        org     = [coder decodeObjectForKey:@"org"];
        url     = [coder decodeObjectForKey:@"url"];
        address = [coder decodeObjectForKey:@"address"];
        state   = [coder decodeObjectForKey:@"state"];
        postalCode = [coder decodeObjectForKey:@"postalCode"];
    }
    return self;
}

@end
