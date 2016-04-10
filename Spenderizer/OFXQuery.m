//
//  OFXQuery.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/8/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "OFXQuery.h"

#define HEADER @"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>\n<?OFX OFXHEADER=\"200\" VERSION=\"211\" SECURITY=\"NONE\" OLDFILEUID=\"NONE\" NEWFILEUID=\"NONE\"?>\n\n<OFX>\n"

#define FOOTER @"</OFX>"

@implementation OFXQuery
@synthesize body;

- (id)init {
    if (self = [super init]) {
        self.body = [NSMutableString string];
    }
    return self;
}

- (NSString *)stringValue {
    return [[NSString stringWithFormat:@"%@%@%@", HEADER, self.body, FOOTER] stringByReplacingOccurrencesOfString:@"\n" withString:@"\r\n"];
}

- (void)replace:(NSString *)toReplace with:(NSString *)newString {
    [self.body replaceOccurrencesOfString:toReplace withString:newString options:NSLiteralSearch range:NSMakeRange(0, self.body.length)];
}

@end

