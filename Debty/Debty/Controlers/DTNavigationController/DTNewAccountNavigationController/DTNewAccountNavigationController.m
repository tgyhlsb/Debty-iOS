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
    NSMutableArray *friends = [[self selectedFriends] mutableCopy];
    [friends addObject:[DTInstallation me]];
    self.accountDraft.personList = friends;
    
    if ([self.topViewController isMemberOfClass:[DTFriendsPickerVC class]]) {
        if ([self.accountDraft.personList count] == 1) {
            [[[UIAlertView alloc] initWithTitle:@"Error"
                                        message:@"Select friends"
                                       delegate:self
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil] show];
        } else if ([self.accountDraft.personList count] == 2) {
            [self createAccount];
        } else {
            [self pushToCreateAccountVC];
        }
    } else if ([self.topViewController isMemberOfClass:[DTCreateAccountVC class]]) {
        [self createAccount];
    }
}

- (void)pushToCreateAccountVC
{
    DTCreateAccountVC *destination = [DTCreateAccountVC newController];
    destination.accountDraft = self.accountDraft;
    [destination setCloseButtonVisible:NO];
    [destination setNextButtonVisible:YES];
    
    
    __weak DTViewController *weakDestination = destination;
    [destination setNextBlock:^{
        [((DTNewAccountNavigationController *)weakDestination.navigationController) nextButtonHandler];
    }];
    
    [self pushViewController:destination animated:YES];
}

- (void)createAccount
{
    [DTModelManager deselectAllPersons];
    DTAccount *account = [DTModelManager accountWithPersons:self.accountDraft.personList];
    account.name = self.accountDraft.name;
    [self selfDissmissWithAccount:account];
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
