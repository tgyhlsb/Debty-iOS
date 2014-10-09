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
#import "DTAccountDraft.h"

@interface DTNewAccountNavigationController ()

@property (strong, nonatomic) DTAccountDraft *accountDraft;

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
        [((DTNewAccountNavigationController *)weakRootVC.navigationController) nextButtonHandler];
    }];
    return navigationController;
}

- (DTAccountDraft *)accountDraft
{
    if (!_accountDraft) {
        _accountDraft = [DTAccountDraft emptyDraft];
    }
    return _accountDraft;
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

- (void)nextButtonHandler
{
    if ([self.topViewController isMemberOfClass:[DTFriendsPickerVC class]]) {
        [self pushToCreateAccountVC];
    } else if ([self.topViewController isMemberOfClass:[DTCreateAccountVC class]]) {
        
    }
}

- (void)pushToCreateAccountVC
{
    NSMutableArray *friends = [[self selectedFriends] mutableCopy];
    [friends addObject:[DTInstallation me]];
    
    if ([friends count] == 2) {
        [DTModelManager deselectAllPersons];
        DTAccount *account = [DTModelManager accountWithPersons:friends];
        [self selfDissmissWithAccount:account];
    } else {
        self.accountDraft.personList = friends;
        DTCreateAccountVC *destination = [DTCreateAccountVC newController];
        destination.accountDraft = self.accountDraft;
        [self pushViewController:destination animated:YES];
    }
}

#pragma mark - Navigation

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return [super popViewControllerAnimated:animated];
}

@end
