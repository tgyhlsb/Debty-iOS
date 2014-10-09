//
//  DTSharesEditorVC.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 17/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTSharesEditorVC.h"
#import "DTShareCell.h"

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

- (void)updateFooter
{
    switch (self.expenseCache.shareType) {
        case DTShareTypeEqually:
        {
            self.footerDetailLabel.hidden = YES;
            self.footerLabel.text = [NSString stringWithFormat:@"%.0f participants", [self.expenseCache totalValue]];
            break;
        }
            
        case DTShareTypeExactly:
        {
            self.footerDetailLabel.hidden = NO;
            self.footerLabel.text = [NSString stringWithFormat:@"%.2f €", [self.expenseCache totalValue]];
            self.footerDetailLabel.text = [NSString stringWithFormat:@"Missing %.2f €", [self.expenseCache errorValue]];
            break;
        }
            
        case DTShareTypePercent:
        {
            self.footerDetailLabel.hidden = NO;
            self.footerLabel.text = [NSString stringWithFormat:@"%.0f %%", [self.expenseCache totalValue]];
            self.footerDetailLabel.text = [NSString stringWithFormat:@"Missing %.2f %%", [self.expenseCache errorValue]];
            break;
        }
            
        case DTShareTypeShare:
        {
            self.footerDetailLabel.hidden = YES;
            self.footerLabel.text = [NSString stringWithFormat:@"%.0f shares", [self.expenseCache totalValue]];
            break;
        }
            
    }
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
    self.fetchedResultsController = [self.expenseCache fetchResultControllerForAvailablePersons];
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
    [self.expenseCache.personAndValueMapping setObject:cell.value forKey:cell.person];
    [self updateFooter];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifer = [DTShareCell reusableIdentifier];
    DTShareCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    cell.person = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.type = self.expenseCache.shareType;
    cell.delegate = self;
    
    // update cell value
    NSDecimalNumber *actualValue = [self.expenseCache.personAndValueMapping objectForKey:cell.person];
    if (!actualValue) {
        actualValue = CELL_DEFAULT_VALUE;
    }
    [self.expenseCache.personAndValueMapping setObject:actualValue forKey:cell.person];
    cell.value = actualValue;
    
    return cell;
}



@end
