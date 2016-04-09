//
//  XMLParser.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/5/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "XMLParser.h"

#define NAMESPACES false
#define NAMESPACES_PREFIXES false
#define RESOLVE_EXTERNAL_ENTITIES false

@implementation XMLParser
@synthesize items;

/*! Parse an XML String
 @param NSString XML String.
 @return NSMutableArray of NSMutableDictionary containing key value XML.
 */
- (NSMutableArray *)parseXMLString:(NSString *)xmlString {
    NSData *xmlFile = [self fixAmpersands:[xmlString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlFile];
    [parser setDelegate:self];
    
    [parser setShouldProcessNamespaces:NAMESPACES];
    [parser setShouldReportNamespacePrefixes:NAMESPACES_PREFIXES];
    [parser setShouldResolveExternalEntities:RESOLVE_EXTERNAL_ENTITIES];
    
    [parser parse];

    return listOfItems;
}

/*! Parse an XML String from a URL
 @param URL to download XML.
 @return NSMutableArray of NSMutableDictionary containing key value XML.
 */
- (NSMutableArray *)parseXMLFileAtURL:(NSString *)URL {
    NSString *agentString = @"Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_6; en-us) AppleWebKit/525.27.1 (KHTML, like Gecko) Version/3.2.1 Safari/525.27.1";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                                    [NSURL URLWithString:URL]];
    [request setValue:agentString forHTTPHeaderField:@"User-Agent"];
   
    NSData *xmlFile = [self fixAmpersands:[ NSURLConnection sendSynchronousRequest:request returningResponse: nil error: nil ]];
   
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlFile];
    [parser setDelegate:self];
    
    [parser setShouldProcessNamespaces:NAMESPACES];
    [parser setShouldReportNamespacePrefixes:NAMESPACES_PREFIXES];
    [parser setShouldResolveExternalEntities:RESOLVE_EXTERNAL_ENTITIES];

    [parser parse];
    
    return listOfItems;
}

#pragma mark - NSXMLParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    errorParsing=NO;
    listOfItems = [[NSMutableArray alloc] init];
    items = [[NSMutableDictionary alloc] init];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"Error parsing XML: %li  %@", (long)[parseError code], parseError);
    errorParsing=YES;
}

/// This is used for the values in the xml Ex. <institutionid name="121 Financial Credit Union" id="666"/>
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    // Find all keys in Element name
    for (id key in attributeDict) {
        // Get the value of the key
        elementValue = [attributeDict objectForKey:key];
        // Store key value pair
        [self addKey:key value:elementValue];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    elementValue = [elementValue stringByAppendingString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    [self addKey:elementName value:elementValue];
    elementValue = @"";
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    if (errorParsing == NO)
    {
        NSLog(@"XML processing done!");
        for (NSMutableDictionary *dict in listOfItems) {
            NSLog(@"dict%@",dict);
        }
    } else {
        NSLog(@"Error occurred during XML processing");
    }
    
}

# pragma mark - Helpers

/*! Adds a key to the items NSMutableDictionary
    if the key already exists in items, then it 
    will store items in an NSMutableArray named
    ListOfItem
 @param NSString key of dictionary
 @param NSString value to insert in dictionary
 */
- (void)addKey:(NSString *)key value:(NSString *)value {
    value = [value stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    // Check if the element key is already in items
    if ([items valueForKey:key]) {
        // Store the old items
        [listOfItems addObject:items];
        // Create a new Items
        items = [[NSMutableDictionary alloc] init];
    }
    [items setValue:value forKey:key];
}

/*! Removes Ampersands from NSData
@param NSData Original data.
@return NSData Data with &amp; instead of &
 */
- (NSData *)fixAmpersands:(NSData*)data  {
    NSString *dataString = [[NSString alloc] initWithBytes: [data bytes] length:[data length] encoding:NSUTF8StringEncoding];
   
    for (NSUInteger i = 0; i < [dataString length]; i++) {
        if ([dataString characterAtIndex:i] == '&') {
            NSString *test =[dataString substringWithRange:NSMakeRange(i, 5)];
            if ([test isEqualToString:@"&amp;"]) {
               // NSLog(@"good!");
            }
            else {
                dataString = [NSString stringWithFormat:@"%@&amp;%@",[dataString substringToIndex:i],[dataString substringFromIndex:i+1]];
               // NSLog(@"new :\n%@",dataString);
            }
        }
    }
    
    return [dataString dataUsingEncoding:NSUTF8StringEncoding];
}

@end
