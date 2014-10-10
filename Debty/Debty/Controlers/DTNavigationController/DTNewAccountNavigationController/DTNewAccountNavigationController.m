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
    [rootViewController setCloseButtonVisible:YES];
    [rootViewController setNextButtonVisible:YES];
    
    DTNewAccountNavigationController *navigationController = [[DTNewAccountNavigationController alloc] initWithRootViewController:rootViewController];
    navigationController.navigationBar.translucent = NO;
    rootViewController.accountDraft = navigationController.accountDraft;
    
    __weak DTViewController *weakRootVC = rootViewController;
    [rootViewController setCloseBlock:^{
        [((DTNewAccountNavigationController *)weakRootVC.navigationController) selfDissmissWithAccount:nil];
    }];
    [rootViewController setNextBlock:^{
        [((DTNewAccountNavigationController *)weakRootVC.navigationController) friendPickerDoneButtonHandler];
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

- (void)friendPickerDoneButtonHandler
{
    if ([self.accountDraft.personList count] == 0) {
        [[[UIAlertView alloc] initWithTitle:@"Error"
                                    message:@"Select friends"
                                   delegate:self
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil] show];
    } else {
        [self pushToCreateAccountVC];
    }
}

- (void)createAccountDoneButtonHandler
{
    [self createAccount];
}

- (void)pushToCreateAccountVC
{
    DTCreateAccountVC *destination = [DTCreateAccountVC newController];
    destination.accountDraft = self.accountDraft;
    [destination setCloseButtonVisible:NO];
    [destination setNextButtonVisible:YES];
    
    
    __weak DTViewController *weakDestination = destination;
    [destination setNextBlock:^{
        [((DTNewAccountNavigationController *)weakDestination.navigationController) createAccountDoneButtonHandler];
    }];
    
    [self pushViewController:destination animated:YES];
}

- (void)createAccount
{
    DTAccount *account = [self.accountDraft accountFromDraft];
    
    [DTModelManager deselectAllPersons];
    [DTModelManager save];
    
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
