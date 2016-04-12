//
//  OFXQuery.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/8/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "OFXQuery.h"

//#define HEADER @"OFXHEADER:100\nDATA:OFXSGML\nVERSION:102 <?xml version=\"1.0\"?>\n<?OFX OFXHEADER=\"100\" VERSION=\"102\" SECURITY=\"NONE\" OLDFILEUID=\"NONE\" NEWFILEUID=\"NONE\"?>\n\n<OFX>\n"

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
    return [[NSString stringWithFormat:@"%@%@%@", [self header], self.body, FOOTER] stringByReplacingOccurrencesOfString:@"\n" withString:@"\r\n"];
}

- (NSString *)header {
    return [OFXUtil loadQueryFromFile:@"OFXHeader"];
}

- (void)replace:(NSString *)toReplace with:(NSString *)newString {
    [self.body replaceOccurrencesOfString:toReplace withString:newString options:NSLiteralSearch range:NSMakeRange(0, self.body.length)];
}

@end

