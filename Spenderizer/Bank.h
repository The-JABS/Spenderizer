//
//  Bank.h
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/5/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bank : NSObject {
    
}
- (id)initWithID:(NSString *)_ID name:(NSString *)_name fid:(NSString *)_fid
             org:(NSString *)_org url:(NSString *)_url;

@property (nonatomic, retain) NSString *ID;         // Bank's OFX ID
@property (nonatomic, retain) NSString *name;       // Banks name
@property (nonatomic, retain) NSString *fid;        // Finacial institution ID
@property (nonatomic, retain) NSString *org;
@property (nonatomic, retain) NSString *url;        // url of bank's OFX Server

// Extra info may be needed for round up savings.
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *postalCode;

@end
