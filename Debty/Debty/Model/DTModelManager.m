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

static DTModelManager *sharedManager;

@interface DTModelManager()

@property (strong, nonatomic) NSManagedObjectContext *context;

@end

@implementation DTModelManager


+ (void)getPersonSample
{
    [DTBackendManager getAllPersons:nil success:^(NSURLSessionDataTask *task, NSDictionary *json) {
        NSArray *personArray = [json objectForKey:@"results"];
        [DTPerson personsWithArray:personArray];
        [DTModelManager save];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

+ (void)updateUser
{

}


#pragma mark - FetchResultController factory -

+ (NSFetchedResultsController *)fetchResultControllerForPersons
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CLASS_NAME_PERSON];
    
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
