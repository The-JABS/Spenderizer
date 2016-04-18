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


//+ (NSString *)getDate {
//    NSDateFormatter* df = [[NSDateFormatter alloc] init];
//    [df setDateFormat:@"yyyyMMddHHmmss.SSS[Z:z]"];
//    
//    return [df stringFromDate:[NSDate date]];
//}


+ (NSString *)getDate {
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyyMMddHHmmss.SSS[Z:z]"];
    
    NSString *date = [df stringFromDate:[NSDate date]];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(\\d+\\.\\d+\\[[+-]?)(0?)(\\d)(\\d{2})(.*)" options:NSRegularExpressionCaseInsensitive error:nil];
    return [regex stringByReplacingMatchesInString:date options:0 range:NSMakeRange(0, date.length) withTemplate:@"$1$3$5"];
}

+ (NSString *)getOldDate {
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyyMMddHHmmss.SSS[x:z]"];
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

+ (NSString *)randomStringWithLength: (int) len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}

+ (id)safeValueForPath:(NSString *)path inDictionary:(NSDictionary *)dict {
    id val = nil;
    @try {
        val = [dict valueForKeyPath:path];
    } @catch (NSException *e) {
        
    }
    return val;
}

+ (UIView *)viewWithImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeCenter;
    return imageView;
}

/*! Removes Ampersands from NSData (This solves problem for BB&T ....)
 @param NSData Original data.
 @return NSData Data with &amp; instead of &
 */
+ (NSData *)fixAmpersands:(NSData*)data  {
    NSString *dataString = [[NSString alloc] initWithBytes: [data bytes] length:[data length] encoding:NSUTF8StringEncoding];
    
    for (NSUInteger i = 0; i < [dataString length]; i++) {
        if ([dataString characterAtIndex:i] == '&') {
            NSString *test =[dataString substringWithRange:NSMakeRange(i, 5)];
            if ([test isEqualToString:@"&amp;"]) {
                // NSLog(@"good!");
            }
            else {
                dataString = [NSString stringWithFormat:@"%@&amp;%@",[dataString substringToIndex:i],[dataString substringFromIndex:i+1]];
                // NSLog(@"new :\n%@",dataString);
            }
        }
    }
    
    return [dataString dataUsingEncoding:NSUTF8StringEncoding];
}
@end
