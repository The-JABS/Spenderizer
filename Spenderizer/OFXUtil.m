//
//  OFXUtil.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/5/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "OFXUtil.h"
#import "OFXQuery.h"

@implementation OFXUtil

+ (NSString *)getDate {
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyyMMddhhmmss"];
    return [df stringFromDate:[NSDate date]];
}

+ (NSString *)getOldDate {
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyyMMddhhmmss"];
    NSDate *old = [[NSDate alloc] initWithTimeIntervalSince1970:1];
    return [df stringFromDate:old];
}

+ (NSString *)loadQueryFromFile:(NSString *)fileName {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@""];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    content = [content stringByReplacingOccurrencesOfString:@" " withString:@""];
    return content;
}

@end
