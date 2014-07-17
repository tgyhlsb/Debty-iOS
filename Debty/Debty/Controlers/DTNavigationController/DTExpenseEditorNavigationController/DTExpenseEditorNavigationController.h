//
//  DTCreateExpenseNavigationController.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTNavigationController.h"
#import "DTAccount+Helpers.h"

@interface DTExpenseEditorNavigationController : DTNavigationController

@property (strong, nonatomic) DTAccount *account;

@end
