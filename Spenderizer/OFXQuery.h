//
//  OFXQuery.h
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/8/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OFXUtil.h"

@interface OFXQuery : NSObject
@property (nonatomic, retain) NSMutableString *body;

- (NSString *)stringValue;
- (void)replace:(NSString *)toReplace with:(NSString *)newString;
@end
