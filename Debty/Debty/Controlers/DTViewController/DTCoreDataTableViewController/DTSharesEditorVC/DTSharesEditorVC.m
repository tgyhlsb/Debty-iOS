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

@end

@implementation DTSharesEditorVC


+ (instancetype)newController
{
    DTSharesEditorVC *controller = [[DTSharesEditorVC alloc] initWithNibName:NIB_NAME bundle:nil];
    return controller;
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
