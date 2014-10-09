//
//  DTNewAccountNavigationController.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 14/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTNewAccountNavigationController.h"
#import "DTFriendsPickerVC.h"
#import "DTCreateAccountVC.h"
#import "DTModelManager.h"
#import "DTInstallation.h"
#import "DTTabBarController.h"

@interface DTNewAccountNavigationController ()

@end

@implementation DTNewAccountNavigationController

+ (DTNewAccountNavigationController *)newController
{
    DTFriendsPickerVC *rootViewController = [DTFriendsPickerVC newController];
    DTNewAccountNavigationController *navigationController = [[DTNewAccountNavigationController alloc] initWithRootViewController:rootViewController];
    [rootViewController setCloseButtonVisible:YES];
    [rootViewController setNextButtonVisible:YES];
    
    navigationController.navigationBar.translucent = NO;
    
    __weak DTViewController *weakRootVC = rootViewController;
    [rootViewController setCloseBlock:^{
        [((DTNewAccountNavigationController *)weakRootVC.navigationController) selfDissmissWithAccount:nil];
    }];
    [rootViewController setNextBlock:^{
        [((DTNewAccountNavigationController *)weakRootVC.navigationController) pushToCreateAccountVC];
    }];
    return navigationController;
}

#pragma mark - Helpers

- (NSArray *)selectedFriends
{
    NSFetchedResultsController *selectedFriendsController = [DTModelManager fetchResultControllerForMainUserFriendsWithSearchString:nil selected:@(YES)];
    NSError *error = nil;
    [selectedFriendsController performFetch:&error];
    if (error) {
        NSLog(@"%@", error);
    }
    return [selectedFriendsController fetchedObjects];
}

#pragma mark - Navigation methods

- (void)selfDissmissWithAccount:(DTAccount *)account
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        if (account) {
            [DTTabBarController setViewForAccount:account animated:YES];
        }
    }];
}

- (void)pushToCreateAccountVC
{
    NSMutableArray *friends = [[self selectedFriends] mutableCopy];
    [friends addObject:[DTInstallation me]];
    [DTModelManager deselectAllPersons];
    DTAccount *account = [DTModelManager accountWithPersons:friends];
    
    if ([friends count] == 2) {
        [self selfDissmissWithAccount:account];
    } else {
        DTCreateAccountVC *destination = [DTCreateAccountVC newController];
        [self pushViewController:destination animated:YES];
    }
}

@end
