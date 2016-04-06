//
//  XMLParser.h
//  Save It
//
//  Created by Benjamin Humphries on 10/7/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
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
