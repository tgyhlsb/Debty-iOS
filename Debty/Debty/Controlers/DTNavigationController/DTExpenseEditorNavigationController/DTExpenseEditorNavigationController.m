//
//  DTCreateExpenseNavigationController.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTExpenseEditorNavigationController.h"
#import "DTExpenseEditorVC.h"
#import "DTModelManager.h"
#import "DTExpenseCache.h"

@interface DTExpenseEditorNavigationController ()

@property (strong, nonatomic) DTExpenseEditorVC *expenseEditorVC;

@end

@implementation DTExpenseEditorNavigationController

+ (instancetype)newNavigationControllerWithAccount:(DTAccount *)account
{
    DTExpense *expense = [DTModelManager newExpenseWithAccount:account];
    return [DTExpenseEditorNavigationController newNavigationControllerWithExpense:expense];
}

+ (instancetype)newNavigationControllerWithExpense:(DTExpense *)expense
{
    DTExpenseEditorVC *rootViewController = [DTExpenseEditorVC newController];
    DTExpenseEditorNavigationController *navigationController = [[DTExpenseEditorNavigationController alloc] initWithRootViewController:rootViewController];
    navigationController.expenseEditorVC = rootViewController;
    
    navigationController.expense = expense;
    
    [rootViewController setNextButtonVisible:YES];
    [rootViewController setCloseButtonVisible:YES];
    
    __weak DTViewController *weakRootVC = rootViewController;
    [rootViewController setCloseBlock:^{
        [((DTExpenseEditorNavigationController *)weakRootVC.navigationController) cancel];
    }];
    [rootViewController setNextBlock:^{
        [((DTExpenseEditorNavigationController *)weakRootVC.navigationController) validate];
    }];
    
    return navigationController;
}

#pragma mark - Getters & setters

@synthesize expense = _expense;

- (void)setExpense:(DTExpense *)expense
{
    _expense = expense;
    
    self.expenseEditorVC.expenseCache = [DTExpenseCache cacheFromExpense:expense];
}

#pragma mark - Navigation methods

- (void)selfDissmiss
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)validate
{
    NSString *error = [self errorForCache:self.expenseEditorVC.expenseCache];
    if (!error) {
        [self.expenseEditorVC.expenseCache saveToExpense:self.expense];
        self.expense.isValid = @(YES);
        [self.expense updateCache];
        [DTModelManager save];
        [self selfDissmiss];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:error delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
}

- (void)cancel
{
    [self selfDissmiss];
}

#pragma mark - Validation

- (NSString *)errorForCache:(DTExpenseCache *)cache
{
    NSString *error = nil;
    if (!cache.name || [cache.name length] <= 0) {
        error = @"Expense has no name";
    } else if (!cache.amount || [cache.amount floatValue] <= 0) {
        error = @"You must enter a valid amount";
    } else if (!cache.whoPayed) {
        error = @"Who payed ?";
    } else if (![cache areSharesValid]) {
        error = @"Invalid shares";
    }
    
    return error;
}

@end
