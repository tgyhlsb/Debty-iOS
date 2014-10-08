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

#define NIB_NAME @"DTSharesEditorVC"

#define CELL_DEFAULT_VALUE [NSDecimalNumber decimalNumberWithString:@"0"]

@interface DTSharesEditorVC () <DTShareCellDelegate>


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

- (NSMapTable *)personsAndValuesMapping
{
    if (!_personsAndValuesMapping) {
        _personsAndValuesMapping = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory
                                                          valueOptions:NSPointerFunctionsStrongMemory];
    }
    return _personsAndValuesMapping;
}

- (void)setExpense:(DTExpense *)expense
{
    _expense = expense;
}

- (void)updateFooter
{
    switch (self.shareType) {
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
    
    NSEnumerator *enumerator = [self.personsAndValuesMapping keyEnumerator];
    DTPerson *key = nil;
    NSDecimalNumber *value = nil;
    CGFloat total = 0;
    
    while ((key = [enumerator nextObject])) {
        value = [self.personsAndValuesMapping objectForKey:key];
        total += [value floatValue];
    }
    return total;
}

- (CGFloat)errorValue
{
    switch (self.shareType) {
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
    [self.personsAndValuesMapping setObject:cell.value forKey:cell.person];
    [self updateFooter];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifer = [DTShareCell reusableIdentifier];
    DTShareCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    cell.person = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.type = self.shareType;
    cell.delegate = self;
    
    // update cell value
    NSDecimalNumber *actualValue = [self.personsAndValuesMapping objectForKey:cell.person];
    if (!actualValue) {
        actualValue = CELL_DEFAULT_VALUE;
    }
    [self.personsAndValuesMapping setObject:actualValue forKey:cell.person];
    cell.value = actualValue;
    
    return cell;
}



@end
