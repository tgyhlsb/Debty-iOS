//
//  DTExpenseNavigationViewController.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTExpenseNavigationViewController.h"
#import "DTAccountsTableVC.h"
#import "DTAccountVC.h"

@interface DTExpenseNavigationViewController ()

@end

@implementation DTExpenseNavigationViewController

+ (instancetype)newController
{
    DTAccountsTableVC *expenseTableVC = [DTAccountsTableVC newController];
    [expenseTableVC setAddExpenseButtonVisible:YES];
    DTExpenseNavigationViewController *navigationController = [[DTExpenseNavigationViewController alloc] initWithRootViewController:expenseTableVC];
    navigationController.title = @"Expenses";
    return navigationController;
}

- (void)setViewForAccount:(DTAccount *)account animated:(BOOL)animated
{
    DTAccountVC *destination = [DTAccountVC newController];
    destination.account = account;
    [self pushViewController:destination animated:animated];
}

@end
