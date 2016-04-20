//
//  Transaction.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/12/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "Transaction.h"

@implementation Transaction
@synthesize datePosted, FITID, memo, name, type;

- (id)init {
    
    if (self = [super init]) {
        
    }
    
    return self;
}

- (BOOL)isEqual:(Transaction *)object {
    return [object.FITID isEqualToString:self.FITID];
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


@end
