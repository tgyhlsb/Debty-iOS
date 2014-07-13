//
//  DTAccountVC.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTCoreDataTableViewController.h"
#import "DTAccount+Helpers.h"

@interface DTAccountVC : DTCoreDataTableViewController

@property (strong, nonatomic) DTAccount *account;

+ (instancetype)newController;

@end
