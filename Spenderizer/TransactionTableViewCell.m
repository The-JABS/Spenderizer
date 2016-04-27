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
    [self update];

}

- (NSArray *)leftButtons {
    NSMutableArray *leftButtons = [[NSMutableArray alloc] init];
    [categoryArray removeAllObjects];
    for (Category *c in [Category categories]) {
        if (c.type != DEPOSIT && c.type != self.transaction.category.type) {
            [leftButtons sw_addUtilityButtonWithColor:c.color icon:c.icon];
            [categoryArray addObject:c];
        }
    }
        
    return leftButtons;
}

- (void)update {
    self.leftUtilityButtons = [self leftButtons];
}

- (Category *)categoryForIndex:(NSInteger)index {
    return [categoryArray objectAtIndex:index];
}


@end
