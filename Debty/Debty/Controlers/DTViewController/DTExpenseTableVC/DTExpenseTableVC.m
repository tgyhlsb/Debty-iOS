//
//  DTExpenseTableVC.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 05/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTExpenseTableVC.h"
#import "DTExpenseTableViewCell.h"
#import "DTNewAccountNavigationController.h"

#define NIB_NAME @"DTExpenseTableVC"

@interface DTExpenseTableVC () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UIBarButtonItem *addExpenseButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;

@property (strong, nonatomic) NSArray *expenses;

@end

@implementation DTExpenseTableVC

+ (DTExpenseTableVC *)newController
{
    DTExpenseTableVC *controller = [[DTExpenseTableVC alloc] initWithNibName:NIB_NAME bundle:nil];
    controller.title = @"Expenses";
    return controller;
}

- (void)generateExpenses
{
    NSMutableArray *tempExpenses = [[NSMutableArray alloc] init];
    for (int i = 0; i < 30; i++) {
        DTTempExpense *expense = [DTTempExpense randomExpense];
        [tempExpenses addObject:expense];
    }
    self.expenses = tempExpenses;
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
    
    [self generateExpenses];
    
    [DTExpenseTableViewCell registerToTableView:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.navigationItem.titleView = self.searchBar;
    
    [self setUpGestureRecognizer];
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
    
}

#pragma mark - UITableViewDataSource 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.expenses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [DTExpenseTableViewCell reusableIdentifier];
    DTExpenseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.expense = [self.expenses objectAtIndex:indexPath.row];
    
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
