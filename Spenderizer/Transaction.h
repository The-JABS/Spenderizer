//
//  Transaction.h
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/12/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Transaction : NSObject

@property (nonatomic, retain) NSDate *datePosted;
@property (nonatomic, retain) NSString *FITID;
@property (nonatomic, retain) NSString *memo;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) float amt;
@property (nonatomic, retain) NSString *type;

@end
