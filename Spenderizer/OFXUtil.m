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

+ (NSString *)getClientID {
    NSString *clientId = [[NSUserDefaults standardUserDefaults] objectForKey:@"clientID"];
    if (!clientId) {
        clientId = [self randomStringWithLength:60];
        [[NSUserDefaults standardUserDefaults] setObject:clientId forKey:@"clientID"];
    }
    return clientId;
}

+ (NSString *) randomStringWithLength: (int) len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}

@end
