//
//  DTNewAccountNavigationController.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 14/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTNewAccountNavigationController.h"
#import "DTFriendsPickerVC.h"

@interface DTNewAccountNavigationController ()

@end

@implementation DTNewAccountNavigationController

+ (DTNewAccountNavigationController *)newController
{
    DTFriendsPickerVC *rootViewController = [DTFriendsPickerVC newController];
    DTNewAccountNavigationController *navigationController = [[DTNewAccountNavigationController alloc] initWithRootViewController:rootViewController];
    [rootViewController setCloseButtonVisible:YES];
    [rootViewController setNextButtonVisible:YES];
    
    __weak DTViewController *weakRootVC = rootViewController;
    [rootViewController setCloseBlock:^{
        [((DTNewAccountNavigationController *)weakRootVC.navigationController) selfDissmiss];
    }];
    [rootViewController setNextBlock:^{
        [((DTNewAccountNavigationController *)weakRootVC.navigationController) pushNextVC];
    }];
    return navigationController;
}

#pragma mark - Navigation methods

- (void)selfDissmiss
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)pushNextVC
{
    [self pushViewController:[[DTViewController alloc] init] animated:YES];
}

@end
