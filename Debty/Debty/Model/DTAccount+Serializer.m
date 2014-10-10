//
//  DTAccount+Serializer.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 21/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTAccount+Serializer.h"
#import "DTModelManager.h"

@implementation DTAccount (Serializer)

+ (DTAccount *)accountWithInfo:(NSDictionary *)info
{
    return [DTAccount accountWithInfo:info
               inManagedObjectContext:[DTModelManager sharedContext]];
}

+ (DTAccount *)accountWithInfo:(NSDictionary *)info
        inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSString *identifier = [info objectForKey:@"id"];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CLASS_NAME_ACCOUNT];
    request.predicate = [NSPredicate predicateWithFormat:@"identifier = %@", identifier];
    
    DTAccount *account = nil;
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (error || !matches || [matches count] > 1) {
        //handle error
    } else {
        if ([matches count]) {
            account = [matches firstObject];
        } else {
            account = [NSEntityDescription insertNewObjectForEntityForName:CLASS_NAME_ACCOUNT inManagedObjectContext:context];
        }
        
        //TODO attributes
        account.name = [info objectForKey:@"label"];
    }
    
    return account;
}

+ (NSArray *)accountsWithArray:(NSArray *)arrayInfo
{
    NSMutableArray *tempAccounts = [[NSMutableArray alloc] init];
    for (NSDictionary *info in arrayInfo) {
        DTAccount *account = [DTAccount accountWithInfo:info];
        [tempAccounts addObject:account];
    }
    return tempAccounts;
}

+ (DTAccount *)accountWithPersons:(NSArray *)persons
{
    return [DTAccount accountWithPersons:persons
                  inManagedObjectContext:[DTModelManager sharedContext]];
}

+ (DTAccount *)accountWithPersons:(NSArray *)persons
           inManagedObjectContext:(NSManagedObjectContext *)context
{
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CLASS_NAME_ACCOUNT];
        request.predicate = [NSPredicate predicateWithFormat:@"(persons.@count == %d) AND (SUBQUERY(persons, $x, $x IN %@).@count == %d)",persons.count, persons, persons.count];
    
        DTAccount *account = nil;
    
        NSError *error = nil;
        NSArray *matches = [context executeFetchRequest:request error:&error];
    
        if (error || !matches || [matches count] > 1) {
            //handle error
        } else {
            if ([matches count] && [persons count] <= 2) { // Only dual-accounts can't be duplicates
                account = [matches firstObject];
            } else {
                account = [NSEntityDescription insertNewObjectForEntityForName:CLASS_NAME_ACCOUNT inManagedObjectContext:context];
                [account setPersons:[NSSet setWithArray:persons]];
            }
        }
    
    return account;
}

+ (DTAccount *)newAccountWithPersons:(NSArray *)persons
{
    return [DTAccount newAccountWithPersons:persons
                     inManagedObjectContext:[DTModelManager sharedContext]];
}

+ (DTAccount *)newAccountWithPersons:(NSArray *)persons
           inManagedObjectContext:(NSManagedObjectContext *)context
{
    DTAccount *account = [NSEntityDescription insertNewObjectForEntityForName:CLASS_NAME_ACCOUNT inManagedObjectContext:context];
    [account setPersons:[NSSet setWithArray:persons]];
    
    return account;
}

@end
