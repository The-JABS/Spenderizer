//
//  BankTableVC.h
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/5/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MetaBankInfo.h"
#import "Loader.h"
#import "BankSignInFormVC.h"

@interface BankTableVC : UITableViewController<UISearchResultsUpdating> {
    NSMutableArray *banks;
    NSMutableArray *searchResults;
    UISearchController *resultsSearchController;
}



@end
