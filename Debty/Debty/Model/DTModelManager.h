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

+ (NSFetchedResultsController *)fetchResultControllerForPersons;
+ (NSFetchedResultsController *)fetchResultControllerForPersonsWithIdentifier:(NSNumber *)identifier;
+ (NSFetchedResultsController *)fetchResultControllerForPersonsWithSearchString:(NSString *)searchString;

+ (NSFetchedResultsController *)fetchResultControllerForAccounts;
+ (NSFetchedResultsController *)fetchResultControllerForAccountsWithSearchString:(NSString *)searchString;

+ (NSFetchedResultsController *)fetchResultControllerForMainUserFriends;
+ (NSFetchedResultsController *)fetchResultControllerForMainUserFriendsWithSearchString:(NSString *)searchString;

@end
