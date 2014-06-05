//
//  DTExpenseTableVC.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 05/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTExpenseTableVC.h"

#define NIB_NAME @"DTExpenseTableVC"

@interface DTExpenseTableVC ()

@property (nonatomic, strong) UIBarButtonItem *addExpenseButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DTExpenseTableVC

+ (DTExpenseTableVC *)newController
{
    DTExpenseTableVC *controller = [[DTExpenseTableVC alloc] initWithNibName:NIB_NAME bundle:nil];
    controller.title = @"Expenses";
    return controller;
}

#pragma mark - Getters

- (UIBarButtonItem *)addExpenseButton
{
    if (!_addExpenseButton) {
        _addExpenseButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addExpenseButtonHandler)];
    }
    return _addExpenseButton;
}

#pragma mark - View methods

- (void)setAddExpenseButtonVisible:(BOOL)visible
{
    if (visible) {
        self.navigationItem.rightBarButtonItem = self.addExpenseButton;
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

#pragma mark - Handlers

- (void)addExpenseButtonHandler
{
    
}

@end
