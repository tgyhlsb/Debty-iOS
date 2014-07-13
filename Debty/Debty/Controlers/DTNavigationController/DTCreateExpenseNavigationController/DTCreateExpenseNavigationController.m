//
//  DTCreateExpenseNavigationController.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTCreateExpenseNavigationController.h"
#import "DTcreateExpenseVC.h"
#import "DTModelManager.h"

@interface DTCreateExpenseNavigationController ()

@property (strong, nonatomic) DTCreateExpenseVC *expenseAttributeVC;

@end

@implementation DTCreateExpenseNavigationController

+ (instancetype)newNavigationController
{
    DTCreateExpenseVC *rootViewController = [DTCreateExpenseVC newController];
    DTCreateExpenseNavigationController *navigationController = [[DTCreateExpenseNavigationController alloc] initWithRootViewController:rootViewController];
    navigationController.expenseAttributeVC = rootViewController;
    
    [rootViewController setNextButtonVisible:YES];
    [rootViewController setCloseButtonVisible:YES];
    
    __weak DTViewController *weakRootVC = rootViewController;
    [rootViewController setCloseBlock:^{
        [((DTCreateExpenseNavigationController *)weakRootVC.navigationController) selfDissmiss];
    }];
    [rootViewController setNextBlock:^{
        [((DTCreateExpenseNavigationController *)weakRootVC.navigationController) createExpense];
    }];
    
    return navigationController;
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
