//
//  DTExpenseDetailsVC.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 08/10/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTExpenseDetailsVC.h"
#import "DTPerson+Helpers.h"
#import "DTModelManager.h"
#import "DTExpenseEditorNavigationController.h"
#import "DTOperationManager.h"

#define NIB_NAME @"DTExpenseDetailsVC"

@interface DTExpenseDetailsVC ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *payDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *whoPayedLabel;

@end

@implementation DTExpenseDetailsVC


+ (instancetype)newController
{
    DTExpenseDetailsVC *controller = [[DTExpenseDetailsVC alloc] initWithNibName:NIB_NAME bundle:nil];
    return controller;
}

- (void)updateView
{
    self.titleLabel.text = self.expense.name;
    self.amountLabel.text = [DTOperationManager currencyStringWithDecimalNumber:self.expense.amount
                                                               withLocaleCode:self.expense.account.localeCode];
    self.whoPayedLabel.text = self.expense.whoPayed.firstName;
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    self.payDateLabel.text = [formatter stringFromDate:self.expense.date];
}

- (void)setUpView
{
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Edit"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(editButtonHandler)];
    self.navigationItem.rightBarButtonItem = flipButton;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpFetchRequest];
    [self setUpView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateView];
}

#pragma mark - Getters & Setters

- (void)setExpense:(DTExpense *)expense
{
    _expense = expense;
    
    [self updateView];
}

#pragma mark - Handlers

- (void)editButtonHandler
{
    DTExpenseEditorNavigationController *destination = [DTExpenseEditorNavigationController newNavigationControllerWithExpense:self.expense];
    [self presentViewController:destination animated:YES completion:^{
        
    }];
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

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    DTShare *share = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSString *amount = [DTOperationManager currencyStringWithDecimalNumber:[share balancedAmount]
                                                          withLocaleCode:share.expense.account.localeCode];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ | %@", share.person.firstName, amount];
    
    return cell;
}

@end
