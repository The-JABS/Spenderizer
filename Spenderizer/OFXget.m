//
//  OFXget.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/5/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "OFXget.h"

#define HEADER @"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>\n<?OFX OFXHEADER=\"200\" VERSION=\"211\" SECURITY=\"NONE\" OLDFILEUID=\"NONE\" NEWFILEUID=\"NONE\"?>\n\n<OFX>\n"

#define FOOTER @"</OFX>"

@implementation OFXget
@synthesize delegate;

- (id)init {
    if (self = [super init]) {
        responce = @"";
    }
    return self;
}

#pragma mark - Retrieving Data

- (NSString *)query:(OFXQuery *)query server:(NSString *)url responceID:(NSString *)resID {
    NSString *result = @"";
    NSString *queryString = [query stringValue];
    
    NSData *postData = [queryString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",url]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-ofx" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    //[request setValue:@"100" forHTTPHeaderField:@"OFXHEADER"];

    [request setHTTPBody:postData];
    
     NSLog(@"\nHERE IS YOUR QUERY to %@ \n%@ \nEND OF THE QUERY",url, [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding]);
    
    NSURLSession *session = [NSURLSession sharedSession];

    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"responce = %@", response);
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
        if (error) {
            NSLog(@"%@", error.description);
        } else {
            NSLog(@"result = %@",result );
        }
        [delegate didFinishDownloading:result withID:resID];
    }] resume];
        
    return result;
}

- (NSString *)query:(OFXQuery *)query server:(NSString *)url {
    return [self query:query server:url responceID:@"0"];
}


@end
