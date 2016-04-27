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


/*
 EMPTY           = 0,
 MISC            = 1,
 FOOD            = 2,
 TRAVEL          = 3,
 ENTERTAINMENT   = 4,
 CUSTOM          = 5
 */

#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

// white
#define EMPTY_CATEGORY [[Category alloc] initWithName:@"Empty" type:EMPTY color:[UIColor whiteColor] icon:nil]

// light blue
#define MISC_CATEGORY [[Category alloc] initWithName:@"Miscellaneous" type:MISC color:[[UIColor alloc] initWithRed:76.0/255.0 green:186.0/255.0 blue:247.0/255.0 alpha:1.0] icon:[UIImage imageNamed:@"miscIcon.png"]]

// light orange
#define FOOD_CATEGORY [[Category alloc] initWithName:@"Food" type:FOOD color:[[UIColor alloc] initWithRed:248.0/255.0 green:194.0/255.0 blue:40.0/255.0 alpha:1.0] icon:[UIImage imageNamed:@"foodIcon.png"]]

#define TRAVEL_CATEGORY [[Category alloc] initWithName:@"Travel" type:TRAVEL color:[[UIColor alloc] initWithRed:230.0/255.0 green:46.0/255.0 blue:37.0/255.0 alpha:1.0] icon:[UIImage imageNamed:@"carIcon.png"]]

#define ENTERTAINMENT_CATEGORY [[Category alloc] initWithName:@"Entertainment" type:ENTERTAINMENT color:[[UIColor alloc] initWithRed:90.0/255.0 green:214.0/255.0 blue:83.0/255.0 alpha:1.0] icon:[UIImage imageNamed:@"entertainmentIcon.png"]]



#define TRANSACTION_HISTORY_KEY @"tHistory"
