//
//  DTTabBarController.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 05/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTTabBarController.h"
#import "DTNavigationController.h"
#import "DTTestVC.h"

#define NIB_NAME @"DTTabBarController"

@interface DTTabBarController ()

@end

@implementation DTTabBarController

+ (DTTabBarController *)newController {
    DTTabBarController *tabBarController = [[DTTabBarController alloc] init];
    
    DTTestVC *vc1 = [DTTestVC newController];
    vc1.view.backgroundColor = [UIColor blueColor];
    DTNavigationController *navigationControllerOne = [DTNavigationController newControllerWithRootViewController:vc1];
    navigationControllerOne.title = @"One";
    
    DTTestVC *vc2 = [DTTestVC newController];
    vc2.view.backgroundColor = [UIColor redColor];
    DTNavigationController *navigationControllerTwo = [DTNavigationController newControllerWithRootViewController:vc2];
    navigationControllerTwo.title = @"Two";
    
    [tabBarController setViewControllers:@[navigationControllerOne, navigationControllerTwo]];
    
    return tabBarController;
}

@end
