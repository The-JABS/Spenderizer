//
//  Loader.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/5/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "Loader.h"

@implementation Loader

/** This method downloads all of the meta data (name, ID) of the banks
 *  that support OFX.  This data is used to create a table view of banks
 *  for the user to choose from.
 *  @return NSMutableArray of MetaBankInfo Objects. (name, ID)
 */
+ (NSMutableArray *)downloadMetaBankInfo {
    // Create an array of MetaBankInfo objects
    NSMutableArray *banks = [[NSMutableArray alloc] init];
    
    NSString *URL = @"http://www.ofxhome.com/api.php?all=yes";
    
    // Grab the data
    NSData *data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString:URL]];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithXMLData:data];

    for (NSDictionary *bank in [dictionary valueForKeyPath:@"institutionid"]) {
        NSString *name = [bank valueForKeyPath:@"_name"];
        NSString *ID = [bank valueForKeyPath:@"_id"];
        if ([self supported:ID])
            [banks addObject:[[MetaBankInfo alloc] initWithName:name ID:ID]];
    }
    return banks;
}

+ (BOOL)supported:(NSString *)ID {
    NSArray *unsupported = @[@"666", @"774", @"553"];
    BOOL supported = true;
    for (NSString *i in unsupported) {
        if ([i isEqualToString:ID]) {
            supported = false;
            break;
        }
    }
    return supported;
}

/** Loads a bank with a given ID from ofxhome, and constructs a Bank object.
 * @param _ID - the ofxhome ID of the bank
 * @param _routingNumber the routing number of the bank.
 * @return a Bank object.
 */
+ (Bank *)loadBankWithID:(NSString *)_ID {
    // The url for getting bank data
    NSString *URL = [NSString stringWithFormat:@"http://www.ofxhome.com/api.php?lookup=%@",_ID];
    
    // Grab the data
    NSData *data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString:URL]];
    
    // Fix any &'s from BB&T ....
    data = [self fixAmpersands:data];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithXMLData:data];
    NSLog(@"CHECK THIS %@",dictionary);
    
    Bank *result = [[Bank alloc] initWithID:[dictionary valueForKeyPath:@"_id"]
                                       name:[dictionary valueForKeyPath:@"name"]
                                        fid:[dictionary valueForKeyPath:@"fid"]
                                        org:[dictionary valueForKeyPath:@"org"]
                                        url:[dictionary valueForKeyPath:@"url"]];
    
    return result;
}

/** Loads extra bank info such as address, city, stat, zip from routingnumbers.info
 * @param routingNumber of desired bank
 * @return Dictionary containing extra bank data.
 */
+ (NSDictionary *)loadBankInformationFromRoutingNumder:(NSString *)routingNumber {
    // Get the data from the routingNumbers API
    NSData *data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString:[NSString stringWithFormat:@"https://www.routingnumbers.info/api/data.json?rn=%@",routingNumber]]];
    NSError*error;
    
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (error)
        NSLog(@"error loading FI Info %@", error);
    
    return result;
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
