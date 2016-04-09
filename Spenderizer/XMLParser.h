//
//  XMLParser.h
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/5/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLParser : NSObject<NSXMLParserDelegate> {
    NSMutableArray *listOfItems;
    NSMutableDictionary *items;
    NSString *elementValue;
    BOOL errorParsing;
    int index;

}
@property (retain,nonatomic) NSMutableDictionary *items;

- (NSMutableArray *)parseXMLFileAtURL:(NSString *)URL;
- (NSMutableArray *)parseXMLString:(NSString *)xmlString;

@end
