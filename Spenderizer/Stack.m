//
//  Stack.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/12/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "Stack.h"

@implementation Stack

- (id)init {
    if (self = [super init]) {
        array = [NSMutableArray array];
    }
    return self;
}

- (void)push:(NSObject *)object {
    [array addObject:object];
}

- (NSObject *)pop {
    NSObject *last = [array lastObject];
    [array removeLastObject];
    return last;
}

- (NSObject *)peek {
    return [array lastObject];
}

- (NSInteger)count {
    return [array count];
}

@end
