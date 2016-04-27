//
//  Category.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/24/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

/**
 EMPTY,
 MISC,
 FOOD,
 TRAVEL,
 ENTERTAINMENT,
 CUSTOM
 */

#import "Category.h"

@implementation Category
@synthesize name, type, color, icon;

- (id)initWithName:(NSString *)_name type:(CategoryType)_type color:(UIColor *)_color icon:(UIImage *)_icon {
    
    if (self = [super init]) {
        name = _name;
        type = _type;
        color = _color;
        icon = _icon;
    }
    return self;
}

// Do no encode image save space.

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:[NSNumber numberWithInt:type] forKey:@"type"];
//    [coder encodeObject:name forKey:@"name"];
//    [coder encodeObject:color forKey:@"color"];
}

- (id)initWithCoder:(NSCoder *)coder {
    type = [[coder decodeObjectForKey:@"type"] intValue];
    self = [[Category categories] objectAtIndex:type];
//    self.name = [coder decodeObjectForKey:@"name"];
//    self.color = [coder decodeObjectForKey:@"color"];
    return self;
}

/*
 EMPTY           = 0,
 MISC            = 1,
 FOOD            = 2, light orange
 TRAVEL          = 3, dark red
 ENTERTAINMENT   = 4, green
 CUSTOM          = 5
 */
+ (NSArray *)categories {
    
    return @[EMPTY_CATEGORY, MISC_CATEGORY, FOOD_CATEGORY, TRAVEL_CATEGORY, ENTERTAINMENT_CATEGORY];
}

@end
