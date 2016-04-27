//
//  CategoriesTableVC.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/27/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "CategoriesTableVC.h"
#import "SWRevealViewController.h"

@interface CategoriesTableVC ()

@end

@implementation CategoriesTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    categories = [Category categories];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MENU BUTTON 40x40.png"] style:UIBarButtonItemStylePlain target:self.revealViewController action:@selector(revealToggle:)];
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    // set the title of the nav bar
    self.navigationItem.title = @"Categories";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [categories count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set the data for this cell:
    Category *category = [categories objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [category name];
    if (category.type != DEPOSIT) {
        [cell.textLabel setTextColor:[UIColor whiteColor]];
    }
    cell.backgroundColor = [category color];
    cell.imageView.image = [category icon];
   
    
    return cell;
}

- (IBAction)addCategory:(id)sender {
    
}

@end
