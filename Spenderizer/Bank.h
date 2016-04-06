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

@property (nonatomic, retain) NSString *ID;         // Bank's OFX ID
@property (nonatomic, retain) NSString *name;       // Banks name
@property (nonatomic, retain) NSString *fid;        // Finacial institution ID
@property (nonatomic, retain) NSString *org;
@property (nonatomic, retain) NSString *url;        // url of bank's OFX Server
@property (nonatomic, retain) NSString *brokerID;   // Not sure if this is needed

@end
