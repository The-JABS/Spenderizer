//
//  Constants.h
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/12/16.
//  Copyright © 2016 The JABS. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Category.h"

extern NSString * const USER_LOGIN_KEY;
extern NSString * const OFX_APP_ID;
extern NSString * const OFX_APP_VERSION;

#define EMPTY_CATEGORY [[Category alloc] initWithName:@"Empty" type:EMPTY color:[UIColor whiteColor] icon:nil];

#define MISC_CATEGORY [[Category alloc] initWithName:@"Miscellaneous" type:MISC color:[UIColor blueColor] icon:[UIImage imageNamed:@"miscIcon.png"]];

#define ENTERTAINMENT_CATEGORY [[Category alloc] initWithName:@"Entertainment" type:ENTERTAINMENT color:[UIColor redColor] icon:[UIImage imageNamed:@"entertainmentIcon.png"]];

#define FOOD_CATEGORY [[Category alloc] initWithName:@"Food" type:ENTERTAINMENT color:[UIColor greenColor] icon:[UIImage imageNamed:@"foodIcon.png"]];