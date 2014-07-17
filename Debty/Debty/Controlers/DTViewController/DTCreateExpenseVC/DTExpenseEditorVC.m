//
//  DTCreateExpenseVC.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTExpenseEditorVC.h"
#import "DTShareSplitCell.h"
#import "DTWhoPayedPickerVC.h"
#import "DTSharesEditorVC.h"

#define NIB_NAME @"DTExpenseEditorVC"

@interface DTExpenseEditorVC () <DTWhoPayedPickerDelegate>
@property (weak, nonatomic) IBOutlet UIView *whoPayedView;
@property (weak, nonatomic) IBOutlet UILabel *whoPayedLabel;
@property (weak, nonatomic) IBOutlet UILabel *whoPayedTitleLabel;

@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *amountLabel;

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
}

#pragma mark - Handlers

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
    DTSharesEditorVC *destination = [DTSharesEditorVC newController];
    destination.expense = self.expense;
    destination.type = DTShareTypeEqually;
    [self.navigationController pushViewController:destination animated:YES];
}

#pragma mark - Expense Attributes

- (NSString *)expenseName
{
    return self.nameLabel.text;
}

- (NSDecimalNumber *)expenseAmount
{
    return [NSDecimalNumber decimalNumberWithString:self.amountLabel.text];
}

#pragma mark - DTWhoPayedPickerDelegate

- (void)whoPayedPickerDidSelectPerson:(DTPerson *)person
{
    self.whoPayed = person;
}

@end
