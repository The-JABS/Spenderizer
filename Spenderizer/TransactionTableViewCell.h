//
//  TransactionTableViewCell.h
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/12/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransactionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *priceLb;

@property (weak, nonatomic) IBOutlet UILabel *nameLb;

@property (weak, nonatomic) IBOutlet UILabel *dateLb;

@property (weak, nonatomic) IBOutlet UIView *colorView;
@end
