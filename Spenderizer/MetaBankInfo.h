//
//  MetaBankInfo.h
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/5/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MetaBankInfo : NSObject

- (id)initWithName:(NSString *)_name ID:(NSString *)_ID;

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *ID;

@end
