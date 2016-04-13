//
//  BankAccountTableViewCell.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/12/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "BankAccountTableViewCell.h"

@implementation BankAccountTableViewCell
@synthesize nameLb, linkBt, account;

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)toggleLink:(UIButton *)sender {
    if (isLinked) {
        // unlink it
        [linkBt setTitle:@"+" forState:UIControlStateNormal];
        [[User sharedInstance] removeBankAccount:account];
    }
    // not linked so
    else {
        // link it
        [linkBt setTitle:@"-" forState:UIControlStateNormal];
        [[User sharedInstance] addBankAccount:account];
    }
    isLinked = !isLinked;
}

@end
