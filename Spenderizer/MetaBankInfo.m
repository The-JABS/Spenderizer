//
//  MetaBankInfo.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/5/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "MetaBankInfo.h"

@implementation MetaBankInfo
@synthesize name, ID;

- (id)initWithName:(NSString *)_name ID:(NSString *)_ID {
    if (self = [super init]) {
        self.name = _name;
        self.ID = _ID;
    }
    return self;
}

@end
