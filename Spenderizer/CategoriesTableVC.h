//
//  CategoriesTableVC.h
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/27/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Category.h"

@interface CategoriesTableVC : UITableViewController {
    NSArray *categories;
}

- (IBAction)addCategory:(id)sender;
@end
