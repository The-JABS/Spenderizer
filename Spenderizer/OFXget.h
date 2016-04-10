//
//  OFXget.h  - This class is used to make a query to and OFX server and get a string
//              responce back!
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/5/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bank.h"
#import "User.h"
#import "OFXQuery.h"

@protocol OFXGetDelegate <NSObject>
- (void)didFinishDownloading:(NSString *)result withID:(NSString *)responceID;
@end

@interface OFXget : NSObject <NSURLConnectionDelegate> {
    id delegate;
    NSString *responce;
    NSString *responceID;
}

- (NSString *)query:(OFXQuery *)query server:(NSString *)url;
- (NSString *)query:(OFXQuery *)query server:(NSString *)url responceID:(NSString *)resID;

@property (nonatomic, retain) id delegate;

@end
