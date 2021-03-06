//
//  OFXUtil.h - Utility methods for OFX
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/5/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XMLDictionary.h"
#import "OFXUtil.h"

@interface OFXUtil : NSObject
+ (NSString *)getDate;
+ (NSString *)loadQueryFromFile:(NSString *)fileName;
+ (NSString *)getOldDate;
+ (NSString *)getTRNUID;
+ (NSString *)getClientID;
+ (id)safeValueForPath:(NSString *)path inDictionary:(NSDictionary *)dict;
+ (UIView *)viewWithImageName:(NSString *)imageName;
+ (NSData *)fixAmpersands:(NSData*)data;

@end
