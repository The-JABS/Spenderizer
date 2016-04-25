//
//  Category.h
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/24/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    EMPTY,
    MISC,
    FOOD,
    TRAVEL,
    ENTERTAINMENT,
    CUSTOM
    
} CategoryType;

@interface Category : NSObject {
    
}

- (id)initWithName:(NSString *)_name type:(CategoryType)_type color:(UIColor *)_color icon:(UIImage *)_icon;

@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) CategoryType type;
@property (nonatomic, assign) UIColor *color;
@property (nonatomic, retain) UIImage *icon;

@end
