//
//  BankAccountsTableVC.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/10/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "BankAccountsTableVC.h"
#import "BankAccountTableViewCell.h"
#import "SWRevealViewController.h"

#define BANK_HEADER_ROW_INDEX 0
#define HEADER_CELL_ID @"BankHeaderCell"
#define ACCOUNT_CELL_ID @"BankAccountCell"


@interface BankAccountsTableVC ()

@end

@implementation BankAccountsTableVC
@synthesize accounts;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // adds the menu button
       self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MENU BUTTON 40x40.png"] style:UIBarButtonItemStylePlain target:self.revealViewController action:@selector(revealToggle:)];
    
      [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
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
    
    if (indexPath.row == BANK_HEADER_ROW_INDEX) {
       MCSwipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HEADER_CELL_ID];
        
        if (cell == nil) {
           cell = [[MCSwipeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:HEADER_CELL_ID];
        }
        
        UIView *crossView = [OFXUtil viewWithImageName:@"cross"];
        UIColor *redColor = [UIColor colorWithRed:232.0 / 255.0 green:61.0 / 255.0 blue:14.0 / 255.0 alpha:1.0];
        
        [cell.detailTextLabel setText:@"Swipe to delete"];
        
        [cell setSwipeGestureWithView:crossView color:redColor mode:MCSwipeTableViewCellModeExit state:MCSwipeTableViewCellState3 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
            NSLog(@"Did swipe \"Cross\" cell");
            
            [user removeAccountsForBank:bank];
            [tableView reloadData];
        }];

        
        cell.textLabel.text = bank.name;
        return cell;
        
    } else {
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ACCOUNT_CELL_ID];
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
        return cell;
    }
    

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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 0) {
        User *user = [User sharedInstance];
        Bank *bank = [[user uniqueBanks] objectAtIndex:indexPath.section];
        BankAccount *account = [[user accountsForBank:bank] objectAtIndex:indexPath.row-1];
        [self performSegueWithIdentifier:@"transaction" sender:account];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"transaction"]) {
        BankAccount *acct = (BankAccount *)sender;
        TransactionTableVC *tableVC = (TransactionTableVC *)segue.destinationViewController;
        [tableVC setAccount:acct];
    }
}


@end
