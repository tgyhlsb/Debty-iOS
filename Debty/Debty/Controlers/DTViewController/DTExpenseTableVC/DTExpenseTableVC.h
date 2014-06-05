//
//  DTExpenseTableVC.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 05/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTViewController.h"

@interface DTExpenseTableVC : DTViewController

+ (DTExpenseTableVC *)newController;

- (void)setAddExpenseButtonVisible:(BOOL)visible;

@end
