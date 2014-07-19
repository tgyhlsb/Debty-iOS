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
        [((DTExpenseEditorNavigationController *)weakRootVC.navigationController) selfDissmiss];
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
    self.expense.isValid = @(YES);
    [DTModelManager save];
    [self selfDissmiss];
}

@end
