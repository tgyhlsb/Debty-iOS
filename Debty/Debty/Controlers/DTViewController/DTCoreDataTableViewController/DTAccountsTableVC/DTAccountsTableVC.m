//
//  DTExpenseTableVC.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 05/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTAccountsTableVC.h"
#import "DTAccountTableViewCell.h"
#import "DTNewAccountNavigationController.h"
#import "DTModelManager.h"
#import "DTAccountVC.h"

#define NIB_NAME @"DTExpenseTableVC"

@interface DTAccountsTableVC () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UIBarButtonItem *addExpenseButton;

@property (nonatomic, strong) UISearchBar *searchBar;

@property (strong, nonatomic) NSArray *expenses;

@end

@implementation DTAccountsTableVC

+ (DTAccountsTableVC *)newController
{
    DTAccountsTableVC *controller = [[DTAccountsTableVC alloc] initWithNibName:NIB_NAME bundle:nil];
    controller.title = @"Expenses";
    controller.canPullToRefresh = YES;
    controller.clearsSelectionOnViewWillAppear = YES;
    return controller;
}

- (void)setUpGestureRecognizer
{
    UITapGestureRecognizer *tableViewTapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewTapHandler)];
    tableViewTapgesture.numberOfTapsRequired = 1;
    tableViewTapgesture.numberOfTouchesRequired = 1;
    [self.tableView addGestureRecognizer:tableViewTapgesture];
}

#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpFetchRequest];
    
    [DTAccountTableViewCell registerToTableView:self.tableView];
    
    self.navigationItem.titleView = self.searchBar;
    
//    [self setUpGestureRecognizer];
}

#pragma mark - Getters

- (UIBarButtonItem *)addExpenseButton
{
    if (!_addExpenseButton) {
        _addExpenseButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addExpenseButtonHandler)];
    }
    return _addExpenseButton;
}

- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.delegate = self;
    }
    return _searchBar;
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

#pragma mark - DTCoreDataTableViewController

- (void)setUpFetchRequest
{
    self.fetchedResultsController = [DTModelManager fetchResultControllerForAccounts];
}

- (void)tableViewShouldRefresh
{
    [self stopRefreshingTableView];
}

#pragma mark - Handlers

- (void)addExpenseButtonHandler
{
    DTNewAccountNavigationController *destination = [DTNewAccountNavigationController newController];
    [self presentViewController:destination animated:YES completion:^{
        
    }];
}

- (void)tableViewTapHandler
{
    [self.searchBar resignFirstResponder];
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self setUpFetchRequest];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [DTAccountTableViewCell reusableIdentifier];
    DTAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    DTAccount *account = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.account = account;
    
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [DTAccountTableViewCell height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTAccountVC *destination = [DTAccountVC newController];
    destination.account = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self.navigationController pushViewController:destination animated:YES];
}

@end
