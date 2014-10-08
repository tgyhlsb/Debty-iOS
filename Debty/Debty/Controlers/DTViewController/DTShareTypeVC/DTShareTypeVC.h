//
//  DTShareTypeVC.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 17/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTViewController.h"
#import "DTExpense.h"
#import "DTShare+Helpers.h"

@interface DTShareTypeVC : DTViewController

@property (strong, nonatomic) DTExpense *expense;
@property (nonatomic) DTShareType shareType;
@property (strong, nonatomic) NSMapTable *personsAndValuesMapping;

@end
