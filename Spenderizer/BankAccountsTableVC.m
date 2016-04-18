//
//  BankAccountsTableVC.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/10/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "BankAccountsTableVC.h"
#import "BankAccountTableViewCell.h"

#define BANK_HEADER_ROW_INDEX 0
#define HEADER_CELL_ID @"BankHeaderCell"
#define ACCOUNT_CELL_ID @"BankAccountCell"

@interface BankAccountsTableVC ()

@end

@implementation BankAccountsTableVC
@synthesize accounts;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set the title of the nav bar
    self.navigationItem.title = @"Accounts";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[[User sharedInstance] uniqueBanks] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    User *user = [User sharedInstance];
    return [[user accountsForBank:[[user uniqueBanks] objectAtIndex:section]] count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    User *user = [User sharedInstance];
    Bank *bank = [[user uniqueBanks] objectAtIndex:indexPath.section];
    
    UITableViewCell *cell = nil;

    if (indexPath.row == BANK_HEADER_ROW_INDEX) {
        cell = [tableView dequeueReusableCellWithIdentifier:HEADER_CELL_ID];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HEADER_CELL_ID];
        }
        
        cell.textLabel.text = bank.name;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:ACCOUNT_CELL_ID];
        if (cell == nil) {
            NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"BankAccountCell" owner:self options:nil];
            for (id currentObject in topLevelObjects) {
                if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                    cell = (BankAccountTableViewCell *)currentObject;
                }
            }
        }

        BankAccountTableViewCell *acctCell = (BankAccountTableViewCell *)cell;
        BankAccount *account = [[user accountsForBank:bank] objectAtIndex:indexPath.row-1];
        acctCell.nameLb.text = [NSString stringWithFormat:@"%@   %@", [account type], [account secureID]];
        acctCell.account = account;
    }
    

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == BANK_HEADER_ROW_INDEX) {
        return 95;
    } else {
        return 65;
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = tableView.tintColor;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == BANK_HEADER_ROW_INDEX) {
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        User *user = [User sharedInstance];
        Bank *bank = [[user uniqueBanks] objectAtIndex:indexPath.section];
        [user removeAccountsForBank:bank];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
