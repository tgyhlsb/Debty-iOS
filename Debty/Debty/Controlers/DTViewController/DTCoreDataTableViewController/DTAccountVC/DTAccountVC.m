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

#define NIB_NAME @"DTAccountVC"

@interface DTAccountVC ()

@property (strong, nonatomic) UIBarButtonItem *addExpenseButton;

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
    [self setAddExpenseButtonVisible:YES];
    
    [DTExpenseTableViewCell registerToTableView:self.tableView];
}

#pragma mark - Setters

- (void)setAccount:(DTAccount *)account
{
    _account = account;
    self.title = [account safeName];
    [self setUpFetchRequest];
}

#pragma mark - Getters

- (UIBarButtonItem *)addExpenseButton
{
    if (!_addExpenseButton) {
        _addExpenseButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addExpenseButtonHandler)];
    }
    return _addExpenseButton;
}

#pragma mark - View methods

- (void)setAddExpenseButtonVisible:(BOOL)visible
{
    if (visible) {
        self.navigationItem.rightBarButtonItem = self.addExpenseButton;
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

#pragma mark - Handlers

- (void)addExpenseButtonHandler
{
    DTExpenseEditorNavigationController *destination = [DTExpenseEditorNavigationController newNavigationController];
    destination.account = self.account;
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

@end
