//
//  BudgetTableVC.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/27/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "BudgetTableVC.h"
#import "SWRevealViewController.h"

@interface BudgetTableVC ()

@end

@implementation BudgetTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MENU BUTTON 40x40.png"] style:UIBarButtonItemStylePlain target:self.revealViewController action:@selector(revealToggle:)];
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    // set the title of the nav bar
    self.navigationItem.title = @"Budget";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[Category categories] count];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
