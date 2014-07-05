//
//  DTPerson+Serializer.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 15/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTPerson+Serializer.h"
#import "DTModelManager.h"

@implementation DTPerson (Serializer)

+ (DTPerson *)personWithInfo:(NSDictionary *)info
{
    return [DTPerson personWithInfo:info
             inManagedObjectContext:[DTModelManager sharedContext]];
}

+ (DTPerson *)personWithInfo:(NSDictionary *)info
      inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSString *identifier = [info objectForKey:@"id"];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CLASS_NAME_PERSON];
    request.predicate = [NSPredicate predicateWithFormat:@"identifier = %@", identifier];
    
    DTPerson *person = nil;
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];

    if (error || !matches || [matches count] > 1) {
        //handle error
    } else {
        if ([matches count]) {
            person = [matches firstObject];
        } else {
            person = [NSEntityDescription insertNewObjectForEntityForName:CLASS_NAME_PERSON inManagedObjectContext:context];
        }

        //TODO attributes
        person.identifier = [info objectForKey:@"id"];
        person.facebookID = [info objectForKey:@"facebook_id"];
        person.firstName = [info objectForKey:@"first_name"];
        person.lastName = [info objectForKey:@"last_name"];
    }
    
    return person;
}

+ (NSArray *)personsWithArray:(NSArray *)arrayInfo
{
    NSMutableArray *tempPersons = [[NSMutableArray alloc] init];
    for (NSDictionary *info in arrayInfo) {
        DTPerson *person = [DTPerson personWithInfo:info];
        [tempPersons addObject:person];
    }
    return tempPersons;
}

@end
