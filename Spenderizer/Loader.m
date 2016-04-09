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
    
    // Parse ALL supported banks from the 'ofx home' site.
    XMLParser *parser = [[XMLParser alloc] init];
    NSMutableArray *bankData = [parser parseXMLFileAtURL:[NSString stringWithFormat:@"http://www.ofxhome.com/api.php?all=yes"]];
    
    // Turn the data into array of MetaBankInfo objects.
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

/** Loads a bank with a given ID from ofxhome, and constructs a Bank object.
 * @param _ID - the ofxhome ID of the bank
 * @param _routingNumber the routing number of the bank.
 * @return a Bank object.
 */
+ (Bank *)loadBankWithID:(NSString *)_ID andRoutingNumber:(NSString *)_routingNumber {
    // Create a parser
    XMLParser *parser = [[XMLParser alloc] init];
    // Parse the responce from OFX HOME. (The site with info about the supported banks NOTE this is not OFX)
    [parser parseXMLFileAtURL:[NSString stringWithFormat:@"http://www.ofxhome.com/api.php?lookup=%@",_ID]];
    // Get the Hash map of the responce
    NSDictionary *items = [parser items];
    // Create a bank object
    Bank *result = [[Bank alloc] initWithID:_ID name:[items objectForKey:@"name"] fid:[items objectForKey:@"fid"] org:[items objectForKey:@"org"] url:[items objectForKey:@"url"] brokerID:[items objectForKey:@"brokerID"]];
    
    // Try to get more info on the bank, based of the routing number
    NSDictionary *dict = [self loadBankInformationFromRoutingNumder:_routingNumber];
    if ([dict objectForKey:@"address"])
        [result setAddress:[dict objectForKey:@"address"]];
    if ([dict objectForKey:@"city"])
        [result setCity:[dict objectForKey:@"city"]];
    if ([dict objectForKey:@"state"])
        [result setState:[dict objectForKey:@"state"]];
    if ([dict objectForKey:@"zip"])
        [result setPostalCode:[dict objectForKey:@"zip"]];
    
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


@end
