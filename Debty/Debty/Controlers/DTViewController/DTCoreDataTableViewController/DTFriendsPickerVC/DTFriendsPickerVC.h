//
//  DTFriendsPickerVC.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 14/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTCoreDataTableViewController.h"
#import "DTAccountDraft.h"

@interface DTFriendsPickerVC : DTCoreDataTableViewController

@property (strong, nonatomic) DTAccountDraft *accountDraft;

+ (DTFriendsPickerVC *)newController;

@end
