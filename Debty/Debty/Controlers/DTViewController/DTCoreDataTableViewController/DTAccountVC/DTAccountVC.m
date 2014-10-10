//
//  DTAccountVC.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTAccountVC.h"
#import "DTModelManager.h"
#import "DTExpenseTableViewCell.h"
#import "DTExpenseEditorNavigationController.h"
#import "DTExpenseDetailsVC.h"

#define NIB_NAME @"DTAccountVC"

@interface DTAccountVC () <UIActionSheetDelegate>

@property (strong, nonatomic) UIBarButtonItem *actionButton;

@end

@implementation DTAccountVC

+ (instancetype)newController
{
    DTAccountVC *controller = [[DTAccountVC alloc] initWithNibName:NIB_NAME bundle:nil];
    return controller;
}

#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpFetchRequest];
    [self setActionButtonVisible:YES];
    
    [DTExpenseTableViewCell registerToTableView:self.tableView];
}

#pragma mark - Setters

- (void)setAccount:(DTAccount *)account
{
    _account = account;
    self.title = account.name;
    [self setUpFetchRequest];
}

#pragma mark - Getters

- (UIBarButtonItem *)actionButton
{
    if (!_actionButton) {
        _actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(actionButtonHandler)];
    }
    return _actionButton;
}

#pragma mark - View methods

- (void)setActionButtonVisible:(BOOL)visible
{
    if (visible) {
        self.navigationItem.rightBarButtonItem = self.actionButton;
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

#pragma mark - Handlers

- (void)actionButtonHandler
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Add expense", @"Account settings", nil];
    
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            [self addExpenseActionHandler];
            break;
        }
            
        case 1:
        {
            break;
        }
            
        case 2:
        {
            break;
        }
    }
}

- (void)addExpenseActionHandler
{
    DTExpenseEditorNavigationController *destination = [DTExpenseEditorNavigationController newNavigationControllerWithAccount:self.account];
    [self presentViewController:destination animated:YES completion:^{
        
    }];
}

#pragma mark - DTCoreDataTableViewController

- (void)setUpFetchRequest
{
    self.fetchedResultsController = [DTModelManager fetchResultControllerForExpensesInAccount:self.account withSearchString:nil];
}

- (void)tableViewShouldRefresh
{
    [self stopRefreshingTableView];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [DTExpenseTableViewCell reusableIdentifier];
    DTExpenseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    DTExpense *expense = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.expense = expense;
    
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [DTExpenseTableViewCell height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTExpense *expense = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    DTExpenseDetailsVC *destination = [DTExpenseDetailsVC newController];
    destination.expense = expense;
    [self.navigationController pushViewController:destination animated:YES];
}

@end
