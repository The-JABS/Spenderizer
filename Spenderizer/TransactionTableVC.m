//
//  TransactionTableVC.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/12/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "TransactionTableVC.h"

#define TABLE_CELL_HEIGHT 116

@interface TransactionTableVC ()

@end

@implementation TransactionTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [userAccount loadAllTransactions];
    [self loadTransactions];
}

- (void)loadTransactions {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setSquare:YES];
    [hud setOpacity:0.7];
    [hud setDetailsLabelText:@"Loading Transactions..."];

    OFXget *get = [[OFXget alloc] init];
    [get setDelegate:self];
    OFXTransactionQuery *qry = [[OFXTransactionQuery alloc] initWithBankAccount:userAccount];
    
    [get query:qry server:userAccount.bank.url];
}

- (void)didFinishDownloading:(NSString *)result withID:(NSString *)responceID {
    NSMutableArray *newTransactions = [NSMutableArray new];
    SGMLParser *parser = [[SGMLParser alloc] init];
    NSDictionary *dictionary = [parser parseXMLString:result];
    NSLog(@"%@", dictionary);
    NSArray *transactionList = [dictionary valueForKeyPath:@"OFX.BANKMSGSRSV1.STMTTRNRS.STMTRS.BANKTRANLIST.STMTTRN"];
    
    for (NSDictionary *transDictionary in transactionList) {
        // parse
        NSString *DTPOSTED  = [transDictionary valueForKeyPath:@"DTPOSTED"];
        NSString *FITID     = [transDictionary valueForKey:@"FITID"];
        NSString *MEMO      = [transDictionary valueForKeyPath:@"MEMO"];
        NSString *NAME      = [transDictionary valueForKeyPath:@"NAME"];
        NSString *TRNAMT    = [transDictionary valueForKeyPath:@"TRNAMT"];
        NSString *TRNTYPE   = [transDictionary valueForKeyPath:@"TRNTYPE"];
    
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
        NSDate *date = [dateFormatter dateFromString:DTPOSTED];
        
        // store
        Transaction *transaction = [[Transaction alloc] init];
        [transaction setDatePosted:date];
        [transaction setFITID:FITID];
        [transaction setMemo:MEMO];
        [transaction setName:NAME];
        [transaction setAmt:[TRNAMT floatValue]];
        [transaction setType:TRNTYPE];
        
        if (transaction.amt > 0.0f) {
            transaction.category = EMPTY_CATEGORY;
        }
        
        // Add to list
        [newTransactions addObject:transaction];

    }
    
    // main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        [userAccount addTransactions:newTransactions];
        [self.tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
    
}

- (void)setAccount:(BankAccount *)bankAccount {
    userAccount = bankAccount;
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
    return [userAccount.transactions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    Transaction *transaction = nil;
    
    TransactionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TransactionCell" owner:self options:nil];
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                cell = (TransactionTableViewCell *)currentObject;
                cell.delegate = self;
            }
        }
        transaction = [userAccount.transactions objectAtIndex:indexPath.row];
    } else {
        transaction = cell.transaction;
    }
    
    // Set the data for this cell:
    [cell setTransaction:transaction];
    
    cell.nameLb.text = [transaction name];
    cell.priceLb.text = [NSString stringWithFormat:@"$%.2f",fabsf([transaction amt])];
    if ([transaction amt] > 0) {
        [cell.priceLb setTextColor:[UIColor greenColor]];
    } else {
        [cell.priceLb setTextColor:[UIColor redColor]];
        
    }
    cell.dateLb.text = [transaction formattedDate];
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return TABLE_CELL_HEIGHT;
}

#pragma mark - SWTableVewDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    TransactionTableViewCell *tranCell = (TransactionTableViewCell *)cell;
    Transaction *tran = [tranCell transaction];
    [tran setCategory:[tranCell categoryForIndex:index]];
    [tranCell setTransaction:tran];
    
    [userAccount saveTransactions];
    [self.tableView reloadData];
}

@end
