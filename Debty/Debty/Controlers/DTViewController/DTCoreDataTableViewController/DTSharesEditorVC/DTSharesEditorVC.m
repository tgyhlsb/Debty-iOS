//
//  DTSharesEditorVC.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 17/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTSharesEditorVC.h"
#import "DTShareCell.h"
#import "DTModelManager.h"
#import "DTShare+Serializer.h"

#define NIB_NAME @"DTSharesEditorVC"

#define CELL_DEFAULT_VALUE [NSDecimalNumber decimalNumberWithString:@"0"]

@interface DTSharesEditorVC () <DTShareCellDelegate>

@property (strong, nonatomic) NSMutableDictionary *cellValues;

@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UILabel *footerDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *footerLabel;

@end

@implementation DTSharesEditorVC


+ (instancetype)newController
{
    DTSharesEditorVC *controller = [[DTSharesEditorVC alloc] initWithNibName:NIB_NAME bundle:nil];
    return controller;
}

- (NSMutableDictionary *)cellValues
{
    if (!_cellValues) {
        _cellValues = [[NSMutableDictionary alloc] init];
    }
    return _cellValues;
}

- (void)setExpense:(DTExpense *)expense
{
    _expense = expense;
    
    if (self.type == expense.type) {
        [self setValuesFromShares];
    }
}

- (void)updateFooter
{
    switch (self.type) {
        case DTShareTypeEqually:
        {
            self.footerDetailLabel.hidden = YES;
            self.footerLabel.text = [NSString stringWithFormat:@"%.0f participants", [self totalValue]];
            break;
        }
            
        case DTShareTypeExactly:
        {
            self.footerDetailLabel.hidden = NO;
            self.footerLabel.text = [NSString stringWithFormat:@"%.2f €", [self totalValue]];
            self.footerDetailLabel.text = [NSString stringWithFormat:@"Missing %.2f €", [self errorValue]];
            break;
        }
            
        case DTShareTypePercent:
        {
            self.footerDetailLabel.hidden = NO;
            self.footerLabel.text = [NSString stringWithFormat:@"%.0f %%", [self totalValue]];
            self.footerDetailLabel.text = [NSString stringWithFormat:@"Missing %.2f %%", [self errorValue]];
            break;
        }
            
        case DTShareTypeShare:
        {
            self.footerDetailLabel.hidden = YES;
            self.footerLabel.text = [NSString stringWithFormat:@"%.0f shares", [self totalValue]];
            break;
        }
            
    }
}

#pragma mark - Values calculation

- (CGFloat)totalValue
{
    NSArray *values = [self.cellValues allValues];
    CGFloat total = 0;
    for (NSDecimalNumber *value in values) {
        total += [value floatValue];
    }
    return total;
}

- (CGFloat)errorValue
{
    switch (self.type) {
        case DTShareTypeEqually:
            return [self totalValue] ? 0.0 : 1.0;
            
        case DTShareTypeExactly:
            return [self.expense.amount floatValue] - [self totalValue];
            
        case DTShareTypePercent:
            return 100.0 - [self totalValue];
            
        case DTShareTypeShare:
            return [self totalValue] ? 0.0 : 1.0;
    }
}

- (DTShare *)shareForPerson:(DTPerson *)person
{
    for (DTShare *share in self.expense.shares) {
        if ([share.person isEqual:person]) {
            return share;
        }
    }
    return [DTShare shareForExpense:self.expense andPerson:person];
}

- (void)setSharesFromValues
{
    [self.expense setType:self.type];
    switch (self.type) {
        case DTShareTypeEqually:
        {
            
            break;
        }
            
        case DTShareTypeExactly:
        {
            for (NSIndexPath *indexPath in [self.cellValues allKeys]) {
                DTPerson *person = [self.fetchedResultsController objectAtIndexPath:indexPath];
                DTShare *share = [self shareForPerson:person];
                share.value = [self.cellValues objectForKey:indexPath];
                NSLog(@"%@", share.value);
            }
            break;
        }
            
        case DTShareTypePercent:
        {
            NSDecimalNumber *totalPayed = [NSDecimalNumber decimalNumberWithString:@"0.00"];
            NSDecimalNumber *totalToPay = [NSDecimalNumber decimalNumberWithString:@"100.00"];
            DTPerson *person = nil;
            DTShare *share = nil;
            for (NSIndexPath *indexPath in [self.cellValues allKeys]) {
                person = [self.fetchedResultsController objectAtIndexPath:indexPath];
                share = [self shareForPerson:person];
                CGFloat percent = [[self.cellValues objectForKey:indexPath] floatValue];
                NSString *stringPercent = [NSString stringWithFormat:@"%.2f", percent];
                NSLog(@"percent = %@", stringPercent);
                share.value = [[NSDecimalNumber alloc] initWithString:stringPercent];
                totalPayed = [totalPayed decimalNumberByAdding:share.value];
                NSLog(@"%@", share.value);
            }
            
            NSDecimalNumber *missing = [totalToPay decimalNumberBySubtracting:totalPayed];
            share.value = [share.value decimalNumberByAdding:missing];
            NSLog(@"-> %@", share.value);
            
            break;
        }
            
        case DTShareTypeShare:
        {
            
            break;
        }
            
    }
}

- (void)setValuesFromShares
{
    
    [self updateFooter];
}

- (BOOL)areSharesValid
{
    return ([self errorValue] == 0.0);
}

#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [DTShareCell registerToTableView:self.tableView];
    
    [self setUpFetchRequest];
    [self updateFooter];
}

#pragma mark - DTCoreDataTableViewController

- (void)setUpFetchRequest
{
    self.fetchedResultsController = [DTModelManager fetchResultControllerForPersonInAccount:self.expense.account];
}

- (void)tableViewShouldRefresh
{
    [self stopRefreshingTableView];
}


#pragma mark - Handlers


#pragma mark - DTShareCellDelegate

- (BOOL)shareCellShouldReturn:(DTShareCell *)cell
{
    return YES;
}

- (void)shareCellValueDidChange:(DTShareCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath) {
        [self.cellValues setObject:cell.value forKey:indexPath];
    }
    [self updateFooter];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifer = [DTShareCell reusableIdentifier];
    DTShareCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    cell.person = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.type = self.type;
    cell.delegate = self;
    
    // update cell value
    if (self.expense.type == self.type) {
        NSDecimalNumber *actualValue = [self.cellValues objectForKey:indexPath];
        if (!actualValue) {
            DTShare *share = [self shareForPerson:cell.person];
            if (share) {
                actualValue = share.value;
            } else {
                actualValue = CELL_DEFAULT_VALUE;
            }
        }
        [self.cellValues setObject:actualValue forKey:indexPath];
        cell.value = actualValue;
    }
    
    return cell;
}



@end
