//
//  DTExpenseTableVC.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 05/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTExpenseTableVC.h"
#import "DTExpenseTableViewCell.h"

#define NIB_NAME @"DTExpenseTableVC"

@interface DTExpenseTableVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIBarButtonItem *addExpenseButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

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

#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self generateExpenses];
    
    [DTExpenseTableViewCell registerToTableView:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [DTExpenseTableViewCell height];
}

@end
