//
//  TransactionTableViewCell.h
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/12/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction.h"
#import "SWTableViewCell.h"

@interface TransactionTableViewCell : SWTableViewCell<SWTableViewCellDelegate> {
    NSMutableArray *categoryArray;
}

@property (nonatomic, retain) Transaction *transaction;

@property (weak, nonatomic) IBOutlet UILabel *priceLb;

@property (weak, nonatomic) IBOutlet UILabel *nameLb;

@property (weak, nonatomic) IBOutlet UILabel *dateLb;

@property (weak, nonatomic) IBOutlet UIView *colorView;

@property (weak, nonatomic) IBOutlet UIImageView *icon;

- (void)setTransaction:(Transaction *)_transaction;
- (Category *)categoryForIndex:(NSInteger)index;

@end
