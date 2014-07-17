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
    return [self.expense.amount floatValue] - [self totalValue];
}

#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [DTShareCell registerToTableView:self.tableView];
    
    [self setUpFetchRequest];
}

#pragma mark - DTCoreDataTableViewController

- (void)setUpFetchRequest
{
    self.fetchedResultsController = [DTModelManager fetchResultControllerForSharesInExpense:self.expense];
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
    [self.cellValues setObject:cell.value forKey:indexPath];
    [self updateFooter];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifer = [DTShareCell reusableIdentifier];
    DTShareCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    cell.share = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.type = self.type;
    cell.delegate = self;
    
    return cell;
}



@end
