//
//  TransactionTableVC.m
//  Spenderizer
//
//  Created by Benjamin Humphries on 4/12/16.
//  Copyright © 2016 The JABS. All rights reserved.
//

#import "TransactionTableVC.h"

@interface TransactionTableVC ()

@end

@implementation TransactionTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadTransactions];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
        NSDate *date = [dateFormatter dateFromString:DTPOSTED];
        
        // store
        Transaction *transaction = [[Transaction alloc] init];
        [transaction setDatePosted:date];
        [transaction setFITID:FITID];
        [transaction setMemo:MEMO];
        [transaction setName:NAME];
        [transaction setAmt:[TRNAMT floatValue]];
        [transaction setType:TRNTYPE];
        
        // Add to list
        [self addTransaction:transaction];
        
    }
    [self.tableView reloadData];
    
    // main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
    
}

- (void)addTransaction:(Transaction *)tran {
    NSMutableSet *set = [[NSMutableSet alloc] initWithArray:transactions];
    [set addObject:tran];
    transactions = [set allObjects];
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
    return [transactions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    TransactionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TransactionCell" owner:self options:nil];
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                cell = (TransactionTableViewCell *)currentObject;
            }
        }
    }
    
    // Set the data for this cell:
    Transaction *transaction = [transactions objectAtIndex:indexPath.row];
    
    cell.nameLb.text = [transaction name];
    cell.priceLb.text = [NSString stringWithFormat:@"%.2f",[transaction amt]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 116;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
