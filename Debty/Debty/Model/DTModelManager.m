//
//  DTModelManager.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 15/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTModelManager.h"
#import <CoreData/CoreData.h>
#import "DTBackendManager.h"
#import "DTInstallation.h"
#import "DTAccount+Serializer.h"
#import "DTPerson+Serializer.h"
#import "DTExpense+Serializer.h"
#import "DTShare+Serializer.h"

static DTModelManager *sharedManager;

@interface DTModelManager()

@property (strong, nonatomic) NSManagedObjectContext *context;

@end

@implementation DTModelManager


+ (DTAccount *)accountWithPersons:(NSArray *)persons
{
    DTAccount *account = [DTAccount accountWithPersons:persons];
    if ([account safeNeedSync]) {
        [DTModelManager save];
    }
    return account;
}

+ (DTExpense *)newExpenseWithAccount:(DTAccount *)account
{
    DTExpense *expense = [DTExpense newExpenseWithAccount:account];
    return expense;
}

#pragma mark - NSNotification

+ (void)notifyMainUserUpdate
{
    [[DTModelManager sharedManager] notifyMainUserUpdate];
}

- (void)notifyMainUserUpdate
{
    [[NSNotificationCenter defaultCenter] postNotificationName:DTNotificationMainUserUpdate object:nil];
}

#pragma mark - Selection methods

+ (void)deselectAllPersons
{
    NSFetchedResultsController *personsController = [DTModelManager fetchResultControllerForPersonsWithSearchString:nil selected:@(YES)];
    NSError *error = nil;
    [personsController performFetch:&error];
    if (error) {
        NSLog(@"[DTModelManager deselectAllPersons]\n%@", error);
    } else {
        NSArray *selectedPersons = [personsController fetchedObjects];
        [selectedPersons makeObjectsPerformSelector:@selector(setIsSelected:) withObject:@(NO)];
        [DTModelManager save];
    }
}


#pragma mark - FetchResultController factory -

#pragma mark Persons

+ (NSFetchedResultsController *)fetchResultControllerForPersonsWithIdentifier:(NSNumber *)identifier
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CLASS_NAME_PERSON];
    
    request.predicate = [NSPredicate predicateWithFormat:@"identifier == %@", identifier];
    
    request.sortDescriptors = @[];
    
    return [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                               managedObjectContext:[DTModelManager sharedContext]
                                                 sectionNameKeyPath:nil
                                                          cacheName:nil];
}

+ (NSFetchedResultsController *)fetchResultControllerForPersons
{
    return [DTModelManager fetchResultControllerForPersonsWithSearchString:nil selected:nil];
}

+ (NSFetchedResultsController *)fetchResultControllerForPersonsWithSearchString:(NSString *)searchString
                                                                       selected:(NSNumber *)selected
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CLASS_NAME_PERSON];
    
    NSMutableArray *predicates = [[NSMutableArray alloc] init];
    
    if (searchString && [searchString length]) {
        NSPredicate *searchStringPredicate = [NSPredicate predicateWithFormat:@"firstName contains[c] %@ || lastName contains[c] %@", searchString, searchString, searchString];
        [predicates addObject:searchStringPredicate];
    }
    if (selected) {
        NSPredicate *isSelectedPredicate = [NSPredicate predicateWithFormat:@"isSelected == %@", selected];
        [predicates addObject:isSelectedPredicate];
    }
    
    if ([predicates count]) {
        request.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
    }
    
    request.sortDescriptors = @[];
    
    return [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                               managedObjectContext:[DTModelManager sharedContext]
                                                 sectionNameKeyPath:nil
                                                          cacheName:nil];
}

+ (NSFetchedResultsController *)fetchResultControllerForPersonInAccount:(DTAccount *)account
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CLASS_NAME_PERSON];
    
    request.predicate = [NSPredicate predicateWithFormat:@"self IN %@.persons", account];
    
    request.sortDescriptors = @[];
    
    return [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                               managedObjectContext:[DTModelManager sharedContext]
                                                 sectionNameKeyPath:nil
                                                          cacheName:nil];
}

#pragma mark Main user friends

+ (NSFetchedResultsController *)fetchResultControllerForMainUserFriends
{
    return [DTModelManager fetchResultControllerForMainUserFriendsWithSearchString:nil selected:nil];
}

+ (NSFetchedResultsController *)fetchResultControllerForMainUserFriendsWithSearchString:(NSString *)searchString
                                                                               selected:(NSNumber *)selected
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CLASS_NAME_PERSON];
    DTPerson *me = [DTInstallation me];
    
    NSPredicate *isFriendPRedicate = [NSPredicate predicateWithFormat:@"ANY friendsInverseRelation == %@", me];
    NSMutableArray *predicates = [[NSMutableArray alloc] initWithObjects:isFriendPRedicate, nil];
    
    
    if (searchString && [searchString length]) {
        NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"firstName contains[c] %@ || lastName contains[c] %@", searchString, searchString, searchString];
        [predicates addObject:searchPredicate];
    }
    if (selected) {
        NSPredicate *isSelectedPredicate = [NSPredicate predicateWithFormat:@"isSelected == %@", selected];
        [predicates addObject:isSelectedPredicate];
    }
    request.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
    
    request.sortDescriptors = @[];
    
    return [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                               managedObjectContext:[DTModelManager sharedContext]
                                                 sectionNameKeyPath:nil
                                                          cacheName:nil];
}

#pragma mark Accounts

+ (NSFetchedResultsController *)fetchResultControllerForAccounts
{
    return [DTModelManager fetchResultControllerForAccountsWithSearchString:nil];
}

+ (NSFetchedResultsController *)fetchResultControllerForAccountsWithSearchString:(NSString *)searchString
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CLASS_NAME_ACCOUNT];
    
    if (searchString && [searchString length]) {
        request.predicate = [NSPredicate predicateWithFormat:@""];
    }
    
    request.sortDescriptors = @[];
    
    return [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                               managedObjectContext:[DTModelManager sharedContext]
                                                 sectionNameKeyPath:nil
                                                          cacheName:nil];
}

#pragma mark Expenses

+ (NSFetchedResultsController *)fetchResultControllerForExpensesInAccount:(DTAccount *)account
{
    return [DTModelManager fetchResultControllerForExpensesInAccount:account withSearchString:nil];
}

+ (NSFetchedResultsController *)fetchResultControllerForExpensesInAccount:(DTAccount *)account withSearchString:(NSString *)searchString
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CLASS_NAME_EXPENSE];
    
    NSPredicate *accountPredicate = [NSPredicate predicateWithFormat:@"account == %@ && isValid == YES", account];
    NSMutableArray *predicates = [[NSMutableArray alloc] initWithObjects:accountPredicate, nil];
    
    
    if (searchString && [searchString length]) {
        NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchString];
        [predicates addObject:searchPredicate];
    }
    request.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
    
    request.sortDescriptors = @[];
    
    return [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                               managedObjectContext:[DTModelManager sharedContext]
                                                 sectionNameKeyPath:nil
                                                          cacheName:nil];
}

#pragma mark Shares

+ (NSFetchedResultsController *)fetchResultControllerForSharesInExpense:(DTExpense *)expense
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CLASS_NAME_SHARE];
    
    NSPredicate *expensePredicate = [NSPredicate predicateWithFormat:@"expense == %@", expense];
    NSMutableArray *predicates = [[NSMutableArray alloc] initWithObjects:expensePredicate, nil];
    
    request.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
    
    request.sortDescriptors = @[];
    
    return [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                               managedObjectContext:[DTModelManager sharedContext]
                                                 sectionNameKeyPath:nil
                                                          cacheName:nil];
}


#pragma mark - Singleton

+ (NSManagedObjectContext *)sharedContext
{
    return [DTModelManager sharedManager].context;
}

+ (DTModelManager *)sharedManager
{
    if (!sharedManager) {
        sharedManager = [[DTModelManager alloc] init];
    }
    return sharedManager;
}

- (NSManagedObjectContext *)context
{
    if (!_context) {
        _context = [self createMainQueueManagedObjectContext];
    }
    return _context;
}

+ (void)save
{
    [sharedManager save];
}

- (void)save
{
    NSError *error;
    [self.context save:&error];
    if (error) {
        NSLog(@"%@", error);
    }
}

+ (void)deleteObject:(NSManagedObject *)object
{
    [sharedManager deleteObject:object];
}


- (void)deleteObject:(NSManagedObject *)object
{
    [self.context deleteObject:object];
    [self save];
}

+ (void)getPersonSample
{
    [DTBackendManager getAllPersons:nil success:^(NSURLSessionDataTask *task, NSDictionary *json) {
        NSArray *personArray = [json objectForKey:@"results"];
        [DTPerson personsWithArray:personArray];
        [DTModelManager save];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - Imported from Stanford Coding Together #13 lesson -

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)createMainQueueManagedObjectContext
{
    NSManagedObjectContext *managedObjectContext = nil;
    NSPersistentStoreCoordinator *coordinator = [self createPersistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)createManagedObjectModel
{
    NSManagedObjectModel *managedObjectModel = nil;
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"debty" withExtension:@"momd"];
    managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)createPersistentStoreCoordinator
{
    NSPersistentStoreCoordinator *persistentStoreCoordinator = nil;
    NSManagedObjectModel *managedObjectModel = [self createManagedObjectModel];
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MOC.sqlite"];
    
    NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
    }
    
    return persistentStoreCoordinator;
}

// Returns the URL to the application's Documents directory

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
