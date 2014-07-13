//
//  DTModelManager.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 15/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTPerson+Serializer.h"
#import "DTAccount+Serializer.h"
#import "DTExpense+Serializer.h"
#import "DTShare+Serializer.h"

static NSString *DTNotificationMainUserUpdate = @"DTNotificationMainUserUpdate";

@interface DTModelManager : NSObject

+ (NSManagedObjectContext *)sharedContext;

+ (void)getPersonSample;

+ (void)deselectAllPersons;

+ (DTAccount *)accountWithPersons:(NSArray *)persons;

+ (NSFetchedResultsController *)fetchResultControllerForPersons;
+ (NSFetchedResultsController *)fetchResultControllerForPersonsWithIdentifier:(NSNumber *)identifier;
+ (NSFetchedResultsController *)fetchResultControllerForPersonsWithSearchString:(NSString *)searchString
                                                                       selected:(NSNumber *)selected;

+ (NSFetchedResultsController *)fetchResultControllerForMainUserFriends;
+ (NSFetchedResultsController *)fetchResultControllerForMainUserFriendsWithSearchString:(NSString *)searchString
                                                                               selected:(NSNumber *)selected;

+ (NSFetchedResultsController *)fetchResultControllerForAccounts;
+ (NSFetchedResultsController *)fetchResultControllerForAccountsWithSearchString:(NSString *)searchString;

+ (NSFetchedResultsController *)fetchResultControllerForExpensesInAccount:(DTAccount *)account;
+ (NSFetchedResultsController *)fetchResultControllerForExpensesInAccount:(DTAccount *)account
                                                         withSearchString:(NSString *)searchString;

@end
