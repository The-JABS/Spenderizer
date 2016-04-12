//
//  SGMLParser.h
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/12/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OFXUtil.h"
#import "Stack.h"

@interface SGMLParser : NSObject<NSXMLParserDelegate> {
    BOOL errorParsing;
}

- (NSDictionary *)parseXMLString:(NSString *)xmlString;
- (NSDictionary *)parseXMLFileAtURL:(NSString *)URL;

@end
