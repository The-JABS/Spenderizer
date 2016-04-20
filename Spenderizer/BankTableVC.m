//
//  BankTableVC.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/5/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "BankTableVC.h"
#import "SWRevealViewController.h"

@interface BankTableVC ()

@end

@implementation BankTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Add main menu button
//    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self.revealViewController action:@selector(revealToggle:)];
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MENU BUTTON 40x40.png"] style:UIBarButtonItemStylePlain target:self.revealViewController action:@selector(revealToggle:)];
//    
//    
//    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    // Search bar
    resultsSearchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    resultsSearchController.searchResultsUpdater = self;
    resultsSearchController.dimsBackgroundDuringPresentation = NO;
    [resultsSearchController setHidesNavigationBarDuringPresentation:NO];
    [resultsSearchController.searchBar sizeToFit];
    
    self.tableView.tableHeaderView = resultsSearchController.searchBar;
    [self.tableView reloadData];
    
    // Set the back button
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setSquare:YES];
    [hud setOpacity:0.7];
    [hud setDetailsLabelText:@"Loading Banks..."];
    
    // Load banks for table in background.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        banks = [Loader downloadMetaBankInfo];
    
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            // Move bb&t to the top ;)
            if ([banks count] > 0) {
                MetaBankInfo *bbt = [self bankWithID:@"475"];
                [banks removeObject:bbt];
                [banks insertObject:bbt atIndex:0];
            }
            
            // create search results for searching
            searchResults = [[NSMutableArray alloc] initWithArray:banks];
            [self.tableView reloadData];
        });
    });
    
}

- (MetaBankInfo *)bankWithID:(NSString *)ID {
    MetaBankInfo *result = NULL;
    for (MetaBankInfo *bank in banks)
        if ([[bank ID] isEqualToString:ID])
            result = bank;
    return result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (resultsSearchController.isActive) {
        return [searchResults count];
    } else {
        return [banks count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set the data for this cell:
    MetaBankInfo *bank = nil;
    
    // Check if we are searching!
    if (resultsSearchController.isActive) {
        bank = [searchResults objectAtIndex:indexPath.row];
    } else {
        bank = [banks objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = [bank name];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (resultsSearchController.isActive) {
        MetaBankInfo *sender = [searchResults objectAtIndex:indexPath.row];
        [resultsSearchController setActive:false];
        [self performSegueWithIdentifier:@"signIn" sender:sender];
    } else {
        [self performSegueWithIdentifier:@"signIn" sender:[banks objectAtIndex:indexPath.row]];
    }
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    searchResults = [[NSMutableArray alloc] initWithArray:[banks filteredArrayUsingPredicate:resultPredicate]];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    // If search bar is empty show all banks.
    if ([searchController.searchBar.text isEqualToString:@""]) {
        searchResults = [[NSMutableArray alloc] initWithArray:banks];
    } else {
        [self filterContentForSearchText:searchController.searchBar.text scope:nil];
    }
    
    [self.tableView reloadData];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // check segue id that is in the mainstoryboard file
    if ([[segue identifier] isEqualToString:@"signIn"]) {
       
        MetaBankInfo *bankInfo = (MetaBankInfo *)sender;
        BankSignInFormVC *signIn = (BankSignInFormVC *)segue.destinationViewController;
        [signIn setBankInfo:bankInfo];
    }
}


@end
