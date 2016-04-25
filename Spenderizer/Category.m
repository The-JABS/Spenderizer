//
//  Category.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/24/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

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

@end
