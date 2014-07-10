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

#define NIB_NAME @"DTTabBarController"

@interface DTTabBarController ()

@end

@implementation DTTabBarController

+ (DTTabBarController *)newController {
    DTTabBarController *tabBarController = [[DTTabBarController alloc] init];
    
    DTAccountsTableVC *expenseTableVC = [DTAccountsTableVC newController];
    [expenseTableVC setAddExpenseButtonVisible:YES];
    DTNavigationController *navigationControllerOne = [DTNavigationController newControllerWithRootViewController:expenseTableVC];
    navigationControllerOne.title = @"Expenses";
    
    DTTestVC *vc2 = [DTTestVC newController];
    DTNavigationController *navigationControllerTwo = [DTNavigationController newControllerWithRootViewController:vc2];
    navigationControllerTwo.title = @"Two";
    
    DTTestVC *vc3 = [DTTestVC newController];
    DTNavigationController *navigationControllerThree = [DTNavigationController newControllerWithRootViewController:vc3];
    navigationControllerThree.title = @"Three";
    
    DTFacebookLoginVC *vc4 = [DTFacebookLoginVC newController];
    DTNavigationController *navigationControllerFour = [DTNavigationController newControllerWithRootViewController:vc4];
    navigationControllerFour.title = @"Four";
    
    [tabBarController setViewControllers:@[navigationControllerOne, navigationControllerTwo, navigationControllerThree, navigationControllerFour]];
    
    return tabBarController;
}

@end
