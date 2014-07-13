//
//  DTExpenseNavigationViewController.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTNavigationController.h"
#import "DTAccount.h"

@interface DTExpenseNavigationViewController : DTNavigationController

+ (instancetype)newController;

- (void)setViewForAccount:(DTAccount *)account animated:(BOOL)animated;

@end
