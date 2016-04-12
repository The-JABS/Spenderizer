//
//  SGMLParser.m
//  ;
//
//  Created by Benjamin Humphries on 4/12/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "SGMLParser.h"

#define NAMESPACES false
#define NAMESPACES_PREFIXES false
#define RESOLVE_EXTERNAL_ENTITIES false

@implementation SGMLParser


- (NSDictionary *)parseXMLString:(NSString *)xmlString {
    xmlString = [xmlString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
     xmlString = [xmlString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    NSMutableDictionary *top = [[NSMutableDictionary alloc] init];
    Stack *stack = [[Stack alloc] init];
    [stack push:top];
    
    NSMutableString *elementNameSoFar = [NSMutableString string];
    NSMutableString *dataSoFar = [NSMutableString string];
    BOOL isBuildingElement = false;
    BOOL isBuildingData    = false;
    BOOL isClosingTag      = false;
    
    for (NSInteger i = 0; i < xmlString.length; i++) {
        if ([xmlString characterAtIndex:i] == '<') {
            
            
            isClosingTag = [self isNextClosingTag:xmlString currentIndex:i];
            
            // If we were building data then store in current dictionary
            if (isBuildingData) {
                NSMutableDictionary *top = (NSMutableDictionary *)[stack peek];
                [top setValue:dataSoFar forKey:elementNameSoFar];
            }
            
            // Start new element
            elementNameSoFar = [NSMutableString string];
            isBuildingElement = true;
            isBuildingData = false;
            
        } else if ([xmlString characterAtIndex:i] == '>') {
            // End element
            isBuildingElement = false;
            if (isClosingTag) {
                NSLog(@"closing %@", elementNameSoFar);
                [stack pop]; // Just pop?
            }
            // Not a closing tag
            else {
                NSInteger next = i + 1;
                if (next < xmlString.length) {
                    // Ignore space
                    while (next < xmlString.length && ([xmlString characterAtIndex:next] == ' ')) {
                        next++;
                    }
                    i = next - 1;
                    
                    // LOOK AHEAD if the next value is an element
                    if ([self isNextElement:xmlString currentIndex:i]) {
                        // Get the current node
                        NSMutableDictionary *top = (NSMutableDictionary *)[stack peek];
                        
                        // What if there are multiple keys with the same name!??!
                        if ([top objectForKey:elementNameSoFar]) {
                            
                            // Create an array to store the multi values
                            NSMutableArray *newArray = [[NSMutableArray alloc] init];
                            
                            // If the old object at this element is an array itself
                            if ([[top objectForKey:elementNameSoFar] isKindOfClass:[NSArray class]]) {
                                // Then copy the values
                                NSArray *oldArray = (NSMutableArray *)[top objectForKey:elementNameSoFar];
                                newArray = [[NSMutableArray alloc] initWithArray:oldArray];
                            } else {
                                // It is a dictionary
                                // Add the current one
                                [newArray addObject:[top objectForKey:elementNameSoFar]];
                                // create the new one that we will be processesing
                            }
                            // Create the new dictionary to process
                            NSDictionary *newDict = [[NSMutableDictionary alloc] init];
                            // Add it to the arry
                            [newArray addObject:newDict];
                            // Set the new value to point to an array
                            [top setValue:newArray forKey:elementNameSoFar];
                            // Push the new Dictionary that we will process
                            [stack push:newDict];
                            
                        } else {
                            // Create a new dictionary node (we know it is a Dict because it has an element in it from look ahead)
                            NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
                            // Add this dict to the current node dictionary
                            [top setValue:newDict forKey:elementNameSoFar];
                            // Make this node the current node dictionary.
                            [stack push:newDict];
                        }
                        
                    }
                    
                    // Or data
                    else {
                        // Start building datavalue
                        isBuildingData = true;
                        dataSoFar = [NSMutableString string];
                    }
                    
    
                
                }
                // NEXT IS OUT OF BOUNDS
                else { NSLog(@"done!"); }

            }
            
            
            
        } else {
            if (isBuildingElement) {
                [elementNameSoFar appendFormat:@"%c",[xmlString characterAtIndex:i]];
            } else if (isBuildingData) {
                [dataSoFar appendFormat:@"%c",[xmlString characterAtIndex:i]];
            } else {
                NSLog(@"hmm where does this go? %c",[xmlString characterAtIndex:i]);
            }
        }
    }
    
    NSLog(@"parse result = %@", top);
    
    return top;
}

# pragma mark - LOOK AHEAD methods

- (BOOL)isNextElement:(NSString *)xmlString currentIndex:(NSInteger)index {
    BOOL isElement = false;
    NSInteger next = index +1;
    if (next < xmlString.length) {
        isElement = ([xmlString characterAtIndex:next] == '<');
    }
    return isElement;
}

- (BOOL)isNextData:(NSString *)xmlString currentIndex:(NSInteger)index {
    return ![self isNextElement:xmlString currentIndex:index];
}

- (BOOL)isNextClosingTag:(NSString *)xmlString currentIndex:(NSInteger)index {
    BOOL isClosing = false;
    NSInteger next = index +1;
    if (next < xmlString.length) {
        isClosing = ([xmlString characterAtIndex:next] == '/');
    }
    return isClosing;
}

@end
