//
//  DTSharesEditorVC.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 17/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTCoreDataTableViewController.h"
#import "DTExpenseCache.h"

@interface DTSharesEditorVC : DTCoreDataTableViewController

@property (strong, nonatomic) DTExpenseCache *expenseCache;

@end
