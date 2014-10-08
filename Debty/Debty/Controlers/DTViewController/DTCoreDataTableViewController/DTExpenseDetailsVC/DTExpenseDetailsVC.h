//
//  DTExpenseDetailsVC.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 08/10/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTCoreDataTableViewController.h"
#import "DTExpense+Helpers.h"

@interface DTExpenseDetailsVC : DTCoreDataTableViewController

@property (strong, nonatomic) DTExpense *expense;

@end
