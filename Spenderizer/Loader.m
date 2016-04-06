//
//  Loader.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/5/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "Loader.h"

@implementation Loader

+ (NSMutableArray *)downloadMetaBankInfo {
    NSMutableArray *banks = [[NSMutableArray alloc] init];
    XMLParser *parser = [[XMLParser alloc] init];
    NSMutableArray *bankData = [parser parseXMLFileAtURL:[NSString stringWithFormat:@"http://www.ofxhome.com/api.php?all=yes"]];
    
    NSString *name = @"";
    NSString *ID = @"";
    for (NSMutableDictionary *dict in bankData) {
        if ([dict objectForKey:@"name"])
            name = [dict objectForKey:@"name"];
        if ([dict objectForKey:@"id"])
            ID = [dict objectForKey:@"id"];
        [banks addObject:[[MetaBankInfo alloc] initWithName:name ID:ID]];
    }
    return banks;
}

@end
