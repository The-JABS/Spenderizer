//
//  BankAccountsTableVC.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/10/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "BankAccountsTableVC.h"

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [accounts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set the data for this cell:
    BankAccount *account = [accounts objectAtIndex:indexPath.row];
  
    cell.textLabel.text = [NSString stringWithFormat:@"%@   %@", [account type], [account secureID]];
    
    return cell;
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
