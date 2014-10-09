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

@interface DTExpenseEditorVC () <DTWhoPayedPickerDelegate, THDatePickerDelegate, DTShareTypeDelegate>

@property (weak, nonatomic) IBOutlet UIView *whoPayedView;
@property (weak, nonatomic) IBOutlet UILabel *whoPayedLabel;
@property (weak, nonatomic) IBOutlet UILabel *whoPayedTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) NSDictionary *datePickerOptions;
@property (strong, nonatomic) THDatePickerViewController *datePicker;

@end

@implementation DTExpenseEditorVC

+ (instancetype)newController
{
    DTExpenseEditorVC *controller = [[DTExpenseEditorVC alloc] initWithNibName:NIB_NAME bundle:nil];
    return controller;
}

#pragma mark - Set up

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

#pragma mark - Getters & Setters

- (THDatePickerViewController *)datePicker
{
    if (!_datePicker) {
        _datePicker = [THDatePickerViewController datePicker];
        _datePicker.date = self.expenseCache.payDate;
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

#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self registerToGestureRecognizer];
    [self registerToTextFieldNotifications];
    
    [self updateView];
}

- (void)updateView
{
    if (self.expenseCache) {
        self.nameTextField.text = self.expenseCache.name;
        self.whoPayedLabel.text = self.expenseCache.whoPayed.firstName;
        self.amountTextField.text = [self.expenseCache.amount stringValue];
        
        if (self.expenseCache.payDate) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd/MM/yyyy"];
            self.dateLabel.text = [formatter stringFromDate:self.expenseCache.payDate];
        } else {
            self.dateLabel.text = @"Pick a date";
        }
    }
}

#pragma mark - Handlers

- (void)nameTextFieldValueDidChange
{
    self.expenseCache.name = self.nameTextField.text;
}

- (void)amountTextFieldValueDidChange
{
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:self.amountTextField.text];
    if (amount && [amount floatValue] >= 0.0f) {
        self.expenseCache.amount = amount;
    }
}

- (void)whoPayedViewTapHandler
{
    DTWhoPayedPickerVC *destination = [DTWhoPayedPickerVC newController];
    destination.expenseCache = self.expenseCache;
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
    destination.expenseCache = self.expenseCache;
    destination.delegate = self;
    
    [self presentViewController:destination animated:YES completion:nil];
}

#pragma mark - DTWhoPayedPickerDelegate

- (void)whoPayedPickerDidSelectPerson:(DTPerson *)person
{
    self.expenseCache.whoPayed = person;
    [self updateView];
}

#pragma mark - DTShareTypeDelegate

- (void)shareTypeVCDidUpdateExpenseCache:(DTExpenseCache *)expenseCache
{
    self.expenseCache = expenseCache;
    [self updateView];
}

#pragma mark - THDatePickerDelegate

- (void)datePickerDonePressed:(THDatePickerViewController *)datePicker
{
    self.expenseCache.payDate = self.datePicker.date;
    [self updateView];
    [self dismissSemiModalView];
}

- (void)datePickerCancelPressed:(THDatePickerViewController *)datePicker
{
    [self dismissSemiModalView];
}

@end
