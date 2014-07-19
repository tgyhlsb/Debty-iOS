//
//  DTCreateExpenseNavigationController.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTNavigationController.h"
#import "DTExpense+Helpers.h"
#import "DTAccount+Helpers.h"

@interface DTExpenseEditorNavigationController : DTNavigationController

+ (instancetype)newNavigationControllerWithAccount:(DTAccount *)account;
+ (instancetype)newNavigationControllerWithExpense:(DTExpense *)expense;

@property (strong, nonatomic) DTExpense *expense;

@end
