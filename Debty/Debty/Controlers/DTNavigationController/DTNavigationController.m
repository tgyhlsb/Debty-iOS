//
//  DTNavigationController.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 05/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTNavigationController.h"

@interface DTNavigationController ()

@end

@implementation DTNavigationController

+ (DTNavigationController *)newControllerWithRootViewController:(UIViewController *)rootVC
{
    DTNavigationController *controller = [[DTNavigationController alloc] initWithRootViewController:rootVC];
    return controller;
}

@end
