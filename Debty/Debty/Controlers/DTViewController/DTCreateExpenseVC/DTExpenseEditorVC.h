//
//  DTCreateExpenseVC.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTViewController.h"
#import "DTAccount.h"
#import "DTPerson.h"

@interface DTExpenseEditorVC : DTViewController

@property (strong, nonatomic) DTAccount *account;
@property (strong, nonatomic) DTPerson *whoPayed;

- (NSString *)expenseName;
- (NSDecimalNumber *)expenseAmount;


@end
