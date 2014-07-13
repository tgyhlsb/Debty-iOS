//
//  DTTabBarController.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 05/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTTabBarController.h"
#import "DTNavigationController.h"
#import "DTAccountsTableVC.h"
#import "DTFacebookLoginVC.h"
#import "DTTestVC.h"
#import "DTExpenseNavigationViewController.h"

#define NIB_NAME @"DTTabBarController"

static DTTabBarController *sharedController;

@interface DTTabBarController ()

@property (strong, nonatomic) DTExpenseNavigationViewController *expenseNavigationController;

@end

@implementation DTTabBarController

+ (DTTabBarController *)sharedController
{
    if (!sharedController) {
        sharedController = [[DTTabBarController alloc] init];
        
        sharedController.expenseNavigationController = [DTExpenseNavigationViewController newController];
        
        DTTestVC *vc2 = [DTTestVC newController];
        DTNavigationController *navigationControllerTwo = [DTNavigationController newControllerWithRootViewController:vc2];
        navigationControllerTwo.title = @"Two";
        
        DTTestVC *vc3 = [DTTestVC newController];
        DTNavigationController *navigationControllerThree = [DTNavigationController newControllerWithRootViewController:vc3];
        navigationControllerThree.title = @"Three";
        
        DTFacebookLoginVC *vc4 = [DTFacebookLoginVC newController];
        DTNavigationController *navigationControllerFour = [DTNavigationController newControllerWithRootViewController:vc4];
        navigationControllerFour.title = @"Four";
        
        [sharedController setViewControllers:@[sharedController.expenseNavigationController, navigationControllerTwo, navigationControllerThree, navigationControllerFour]];
    }
    return sharedController;
}

+ (void)setViewForAccount:(DTAccount *)account animated:(BOOL)animated
{
    [[DTTabBarController sharedController] setViewForAccount:account animated:animated];
}

- (void)setViewForAccount:(DTAccount *)account animated:(BOOL)animated
{
    [self.expenseNavigationController setViewForAccount:account animated:animated];
}


@end
