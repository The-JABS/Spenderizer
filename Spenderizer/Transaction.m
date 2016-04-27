//
//  Transaction.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/12/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "Transaction.h"

@implementation Transaction
@synthesize datePosted, FITID, memo, name, type, category, amt;

- (id)init {
    
    if (self = [super init]) {
        category = MISC_CATEGORY;
    }
    
    return self;
}


- (BOOL)isEqual:(NSObject *)object {
    if ([object isKindOfClass:[Transaction class]]) {
        return (!self.FITID && ![(Transaction *)object FITID]) ||
        [self.FITID isEqual:[(Transaction *)object FITID]] || [self.FITID isEqualToString:[(Transaction *)object FITID]];
    }
    return NO;
}


- (NSString *)formattedDate {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterMediumStyle];
    [df setTimeStyle:NSDateFormatterNoStyle];
    return [df stringFromDate:datePosted];
}

-(NSComparisonResult) compare:(Transaction *) other {
    return [other.datePosted compare:self.datePosted];
}


- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:datePosted forKey:@"datePosted"];
    [coder encodeObject:FITID forKey:@"FITID"];
    [coder encodeObject:memo forKey:@"memo"];
    [coder encodeObject:name forKey:@"name"];
    [coder encodeObject:type forKey:@"type"];
    [coder encodeObject:category forKey:@"category"];
    [coder encodeObject:[NSNumber numberWithFloat:amt] forKey:@"amt"];
    
}

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        datePosted = [coder decodeObjectForKey:@"datePosted"];
        FITID   = [coder decodeObjectForKey:@"FITID"];
        memo    = [coder decodeObjectForKey:@"memo"];
        name    = [coder decodeObjectForKey:@"name"];
        type    = [coder decodeObjectForKey:@"type"];
        category = [coder decodeObjectForKey:@"category"];
        amt      = [[coder decodeObjectForKey:@"amt"] floatValue];
    }
    return self;
}

@end
