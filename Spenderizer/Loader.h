//
//  Loader.h
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/5/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLParser.h"
#import "MetaBankInfo.h"

@interface Loader : NSObject

+ (NSMutableArray *)downloadMetaBankInfo;

@end