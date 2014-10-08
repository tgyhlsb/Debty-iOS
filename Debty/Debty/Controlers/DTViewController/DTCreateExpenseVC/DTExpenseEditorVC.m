//
//  DTCreateExpenseVC.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTExpenseEditorVC.h"
#import "DTShareTypeVC.h"
#import "DTWhoPayedPickerVC.h"
#import "DTSharesEditorVC.h"

#define NIB_NAME @"DTExpenseEditorVC"

@interface DTExpenseEditorVC () <DTWhoPayedPickerDelegate>
@property (weak, nonatomic) IBOutlet UIView *whoPayedView;
@property (weak, nonatomic) IBOutlet UILabel *whoPayedLabel;
@property (weak, nonatomic) IBOutlet UILabel *whoPayedTitleLabel;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;

@end

@implementation DTExpenseEditorVC

+ (instancetype)newController
{
    DTExpenseEditorVC *controller = [[DTExpenseEditorVC alloc] initWithNibName:NIB_NAME bundle:nil];
    return controller;
}

- (void)registerToGestureRecognizer
{
    UITapGestureRecognizer *whoPayedTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whoPayedViewTapHandler)];
    whoPayedTapRecognizer.numberOfTapsRequired = 1;
    whoPayedTapRecognizer.numberOfTouchesRequired = 1;
    [self.whoPayedView addGestureRecognizer:whoPayedTapRecognizer];
}

- (void)registerToTextFieldNotifications
{
    [self.nameTextField addTarget:self action:@selector(nameTextFieldValueDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.amountTextField addTarget:self action:@selector(amountTextFieldValueDidChange) forControlEvents:UIControlEventEditingChanged];
}

- (void)setWhoPayed:(DTPerson *)whoPayed
{
    _whoPayed = whoPayed;
    self.whoPayedLabel.text = whoPayed.firstName;
}

#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self registerToGestureRecognizer];
    [self registerToTextFieldNotifications];
}

#pragma mark - Handlers

- (void)nameTextFieldValueDidChange
{
    self.expense.name = self.nameTextField.text;
}

- (void)amountTextFieldValueDidChange
{
    self.expense.amount = [NSDecimalNumber decimalNumberWithString:self.amountTextField.text];
}

- (void)whoPayedViewTapHandler
{
    DTWhoPayedPickerVC *destination = [DTWhoPayedPickerVC newController];
    destination.expense = self.expense;
    destination.whoPayed = self.whoPayed;
    destination.delegate = self;
    [self.navigationController pushViewController:destination animated:YES];
}

- (IBAction)shareEditorButtonHandler
{
    DTShareTypeVC *destination = [DTShareTypeVC newController];
    destination.expense = self.expense;
    [self presentViewController:destination animated:YES completion:nil];
}

#pragma mark - Expense Attributes

- (NSString *)expenseName
{
    return self.nameTextField.text;
}

- (NSDecimalNumber *)expenseAmount
{
    return [NSDecimalNumber decimalNumberWithString:self.amountTextField.text];
}

#pragma mark - DTWhoPayedPickerDelegate

- (void)whoPayedPickerDidSelectPerson:(DTPerson *)person
{
    self.whoPayed = person;
}

@end
