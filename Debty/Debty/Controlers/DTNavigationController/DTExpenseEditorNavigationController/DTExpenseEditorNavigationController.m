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

@interface DTExpenseEditorNavigationController ()

@property (strong, nonatomic) DTExpenseEditorVC *expenseAttributeVC;

@end

@implementation DTExpenseEditorNavigationController

+ (instancetype)newNavigationController
{
    DTExpenseEditorVC *rootViewController = [DTExpenseEditorVC newController];
    DTExpenseEditorNavigationController *navigationController = [[DTExpenseEditorNavigationController alloc] initWithRootViewController:rootViewController];
    navigationController.expenseAttributeVC = rootViewController;
    
    rootViewController.account = navigationController.account;
    
    [rootViewController setNextButtonVisible:YES];
    [rootViewController setCloseButtonVisible:YES];
    
    __weak DTViewController *weakRootVC = rootViewController;
    [rootViewController setCloseBlock:^{
        [((DTExpenseEditorNavigationController *)weakRootVC.navigationController) selfDissmiss];
    }];
    [rootViewController setNextBlock:^{
        [((DTExpenseEditorNavigationController *)weakRootVC.navigationController) createExpense];
    }];
    
    return navigationController;
}

- (void)setAccount:(DTAccount *)account
{
    _account = account;
    self.expenseAttributeVC.account = account;
}

#pragma mark - Navigation methods

- (void)selfDissmiss
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)createExpense
{
    DTExpense *expense = [DTModelManager expenseWithAccount:self.account];
    expense.name = [self.expenseAttributeVC expenseName];
    expense.amount = [self.expenseAttributeVC expenseAmount];
    [DTModelManager save];
    [self selfDissmiss];
}

@end
