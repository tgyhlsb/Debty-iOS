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
#import "THDatePickerViewController.h"

#define NIB_NAME @"DTExpenseEditorVC"

@interface DTExpenseEditorVC () <DTWhoPayedPickerDelegate, THDatePickerDelegate>
@property (weak, nonatomic) IBOutlet UIView *whoPayedView;
@property (weak, nonatomic) IBOutlet UILabel *whoPayedLabel;
@property (weak, nonatomic) IBOutlet UILabel *whoPayedTitleLabel;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) NSDate *payDate;
@property (strong, nonatomic) NSDictionary *datePickerOptions;
@property (strong, nonatomic) THDatePickerViewController *datePicker;

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
    
    UITapGestureRecognizer *dateTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dateLabelTapHandler)];
    dateTapRecognizer.numberOfTapsRequired = 1;
    dateTapRecognizer.numberOfTouchesRequired = 1;
    [self.dateLabel addGestureRecognizer:dateTapRecognizer];
    self.dateLabel.userInteractionEnabled = YES;
}

- (void)registerToTextFieldNotifications
{
    [self.nameTextField addTarget:self action:@selector(nameTextFieldValueDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.amountTextField addTarget:self action:@selector(amountTextFieldValueDidChange) forControlEvents:UIControlEventEditingChanged];
}

- (void)setWhoPayed:(DTPerson *)whoPayed
{
    _whoPayed = whoPayed;
    self.expense.whoPayed = whoPayed;
    self.whoPayedLabel.text = whoPayed.firstName;
}

- (THDatePickerViewController *)datePicker
{
    if (!_datePicker) {
        _datePicker = [THDatePickerViewController datePicker];
        _datePicker.date = [NSDate date];
        _datePicker.delegate = self;
        [_datePicker setAllowClearDate:NO];
        [_datePicker setAutoCloseOnSelectDate:NO];
        [_datePicker setDisableFutureSelection:YES];
        [_datePicker setSelectedBackgroundColor:[UIColor colorWithRed:125/255.0 green:208/255.0 blue:0/255.0 alpha:1.0]];
        [_datePicker setCurrentDateColor:[UIColor colorWithRed:242/255.0 green:121/255.0 blue:53/255.0 alpha:1.0]];
        
        [_datePicker setDateHasItemsCallback:^BOOL(NSDate *date) {
            return NO;
        }];
    }
    return _datePicker;
}

- (NSDictionary *)datePickerOptions
{
    return @{KNSemiModalOptionKeys.pushParentBack    : @(NO),
             KNSemiModalOptionKeys.animationDuration : @(0.5),
             KNSemiModalOptionKeys.shadowOpacity     : @(0.2)
             };
}

- (void)setPayDate:(NSDate *)payDate
{
    _payDate = payDate;
    self.expense.date = payDate;
    
    if (payDate) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy"];
        self.dateLabel.text = [formatter stringFromDate:payDate];
    }
}

#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self registerToGestureRecognizer];
    [self registerToTextFieldNotifications];
    
    self.dateLabel.text = @"Pick a date";
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

- (void)dateLabelTapHandler
{
    //[self.datePicker slideUpInView:self.view withModalColor:[UIColor lightGrayColor]];
    [self presentSemiViewController:self.datePicker withOptions:self.datePickerOptions];
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

#pragma mark - THDatePickerDelegate

- (void)datePickerDonePressed:(THDatePickerViewController *)datePicker
{
    self.payDate = self.datePicker.date;
    [self dismissSemiModalView];
}

- (void)datePickerCancelPressed:(THDatePickerViewController *)datePicker
{
    [self dismissSemiModalView];
}

@end
