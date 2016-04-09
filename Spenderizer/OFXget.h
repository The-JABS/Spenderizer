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

@protocol OFXDownloadDelegate <NSObject>
-(void)didFinishDownloading:(NSString *)result;
@end

@interface OFXget : NSObject <NSURLConnectionDelegate> {
    id delegate;
    NSString *responce;
}

- (NSString *)query:(OFXQuery *)query server:(NSString *)url;
@property (nonatomic, retain) id delegate;

@end
