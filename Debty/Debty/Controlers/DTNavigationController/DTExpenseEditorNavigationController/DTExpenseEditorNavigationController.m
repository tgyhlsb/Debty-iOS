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

@property (strong, nonatomic) DTExpenseEditorVC *expenseEditorVC;

@end

@implementation DTExpenseEditorNavigationController

+ (instancetype)newNavigationController
{
    DTExpenseEditorVC *rootViewController = [DTExpenseEditorVC newController];
    DTExpenseEditorNavigationController *navigationController = [[DTExpenseEditorNavigationController alloc] initWithRootViewController:rootViewController];
    navigationController.expenseEditorVC = rootViewController;
    
    rootViewController.expense = navigationController.expense;
    
    [rootViewController setNextButtonVisible:YES];
    [rootViewController setCloseButtonVisible:YES];
    
    __weak DTViewController *weakRootVC = rootViewController;
    [rootViewController setCloseBlock:^{
        [((DTExpenseEditorNavigationController *)weakRootVC.navigationController) selfDissmiss];
    }];
    [rootViewController setNextBlock:^{
        [((DTExpenseEditorNavigationController *)weakRootVC.navigationController) validate];
    }];
    
    return navigationController;
}

- (void)setExpense:(DTExpense *)expense
{
    _expense = expense;
    self.expenseEditorVC.expense = expense;
}

#pragma mark - Navigation methods

- (void)selfDissmiss
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)validate
{
//    DTExpense *expense = [DTModelManager expenseWithAccount:self.account];
//    expense.name = [self.expenseEditorVC expenseName];
//    expense.amount = [self.expenseEditorVC expenseAmount];
//    [DTModelManager save];
    [self selfDissmiss];
}

@end
