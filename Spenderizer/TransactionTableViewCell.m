//
//  TransactionTableViewCell.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/12/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "TransactionTableViewCell.h"

@implementation TransactionTableViewCell
@synthesize priceLb, nameLb, dateLb, colorView, icon, transaction;

- (void)awakeFromNib {
    [super awakeFromNib];
    categoryArray = [NSMutableArray new];
    self.leftUtilityButtons = [self leftButtons];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setTransaction:(Transaction *)_transaction {
    transaction = _transaction;
    [self.colorView setBackgroundColor:[_transaction.category color]];
    [self.icon setImage:[_transaction.category icon]];
}

- (NSArray *)leftButtons {
    NSMutableArray *leftButtons = [[NSMutableArray alloc] init];
    Category *category = MISC_CATEGORY;
    [leftButtons sw_addUtilityButtonWithColor:category.color icon:category.icon];
    [categoryArray addObject:category];
    
    category = ENTERTAINMENT_CATEGORY;
    [leftButtons sw_addUtilityButtonWithColor:category.color icon:category.icon];
    [categoryArray addObject:category];
    
    category = FOOD_CATEGORY;
    [leftButtons sw_addUtilityButtonWithColor:category.color icon:category.icon];
    [categoryArray addObject:category];
    
    return leftButtons;
}

- (Category *)categoryForIndex:(NSInteger)index {
    return [categoryArray objectAtIndex:index];
}

@end
