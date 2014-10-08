//
//  DTSharesEditorVC.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 17/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTCoreDataTableViewController.h"
#import "DTExpense+Helpers.h"
#import "DTShare+Helpers.h"

@interface DTSharesEditorVC : DTCoreDataTableViewController

@property (strong, nonatomic) DTExpense *expense;

@property (nonatomic) DTShareType shareType;
@property (strong, nonatomic) NSMapTable *personsAndValuesMapping;

- (BOOL)areSharesValid;

@end
