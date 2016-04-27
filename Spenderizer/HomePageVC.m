//
//  HomePageVC.m
//  Spenderizer
//
//  Created by Jackson Foley on 4/10/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "HomePageVC.h"
#import "SWRevealViewController.h"
#import "User.h"
#import "BankAccount.h"
#import "Transaction.h"

@interface HomePageVC ()

@end

@implementation HomePageVC
@synthesize pieChart;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [self addPieChart];
    
}

- (void)addPieChart {
    
    // Get all bank accounts from the users spenderizer account
    NSArray* bankAccounts = [[User sharedInstance] bankAccounts];

    // Store all transactions
    NSMutableArray *allTransactions = [NSMutableArray new];
    for (BankAccount *bankAccount in bankAccounts) {
        [bankAccount loadAllTransactions];
        if ([bankAccount transactions].count > 0)
            [allTransactions addObjectsFromArray:(NSArray *)[bankAccount transactions]];
    }
    
    // Add up all categories
    NSMutableDictionary*categoryTotals = [[NSMutableDictionary alloc] init];
    for (Transaction *transaction in allTransactions) {
         if (transaction.amt < 0 && transaction.category) {
             NSString *key =[NSString stringWithFormat:@"%i",[transaction.category type]];
             NSNumber *totalSoFar = [categoryTotals objectForKey:key];
       
             totalSoFar = [NSNumber numberWithFloat:[totalSoFar floatValue] + transaction.amt];
        
             [categoryTotals setObject:totalSoFar forKey:key];
         }
    }
    
    NSMutableArray *items = [NSMutableArray new];
    for (NSInteger i = 1; i < [Category categories].count; i++) {
        Category *category = [[Category categories] objectAtIndex:i];
        NSString *key =[NSString stringWithFormat:@"%i",[category type]];
        NSNumber *number = [categoryTotals objectForKey:key];
        [items addObject:[PNPieChartDataItem dataItemWithValue:fabsf([number floatValue]) color:category.color description:category.name]];
    }
    
    CGRect rect = pieChart.frame;
    
    PNPieChart *pChart = [[PNPieChart alloc] initWithFrame:CGRectMake(rect.origin.x - rect.size.width/2.2, rect.origin.y, rect.size.width, rect.size.height) items:items];
    pChart.descriptionTextColor = [UIColor whiteColor];
    pChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:14.0];
    [pieChart setCenter:CGPointMake(0, 0)];
    [self.view addSubview:pChart];
    [pChart strokeChart];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
