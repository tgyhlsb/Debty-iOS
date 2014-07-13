//
//  DTWhoPayedPickerVC.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTCoreDataTableViewController.h"
#import "DTAccount.h"

@protocol DTWhoPayedPickerDelegate;

@interface DTWhoPayedPickerVC : DTCoreDataTableViewController

@property (weak, nonatomic) id<DTWhoPayedPickerDelegate> delegate;

@property (strong, nonatomic) DTAccount *account;
@property (strong, nonatomic) DTPerson *whoPayed;

@end

@protocol DTWhoPayedPickerDelegate <NSObject>

- (void)whoPayedPickerDidSelectPerson:(DTPerson *)person;

@end
