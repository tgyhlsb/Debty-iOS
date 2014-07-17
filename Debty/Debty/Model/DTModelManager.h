//
//  DTModelManager.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 15/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTPerson+Helpers.h"
#import "DTAccount+Helpers.h"
#import "DTExpense+Helpers.h"
#import "DTShare+Helpers.h"

static NSString *DTNotificationMainUserUpdate = @"DTNotificationMainUserUpdate";

@interface DTModelManager : NSObject

+ (NSManagedObjectContext *)sharedContext;

+ (void)save;
+ (void)getPersonSample;
+ (void)deselectAllPersons;

+ (DTAccount *)accountWithPersons:(NSArray *)persons;
+ (DTExpense *)expenseWithAccount:(DTAccount *)account;

+ (NSFetchedResultsController *)fetchResultControllerForPersons;
+ (NSFetchedResultsController *)fetchResultControllerForPersonsWithIdentifier:(NSNumber *)identifier;
+ (NSFetchedResultsController *)fetchResultControllerForPersonsWithSearchString:(NSString *)searchString
                                                                       selected:(NSNumber *)selected;
+ (NSFetchedResultsController *)fetchResultControllerForPersonInAccount:(DTAccount *)account;

+ (NSFetchedResultsController *)fetchResultControllerForMainUserFriends;
+ (NSFetchedResultsController *)fetchResultControllerForMainUserFriendsWithSearchString:(NSString *)searchString
                                                                               selected:(NSNumber *)selected;

+ (NSFetchedResultsController *)fetchResultControllerForAccounts;
+ (NSFetchedResultsController *)fetchResultControllerForAccountsWithSearchString:(NSString *)searchString;

+ (NSFetchedResultsController *)fetchResultControllerForExpensesInAccount:(DTAccount *)account;
+ (NSFetchedResultsController *)fetchResultControllerForExpensesInAccount:(DTAccount *)account
                                                         withSearchString:(NSString *)searchString;

+ (NSFetchedResultsController *)fetchResultControllerForSharesInExpense:(DTExpense *)expense;

@end
