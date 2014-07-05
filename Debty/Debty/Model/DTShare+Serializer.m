//
//  DTShare+Serializer.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 21/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTShare+Serializer.h"
#import "DTModelManager.h"

@implementation DTShare (Serializer)

+ (DTShare *)shareWithInfo:(NSDictionary *)info
{
    return [DTShare shareWithInfo:info
           inManagedObjectContext:[DTModelManager sharedContext]];
}

+ (DTShare *)shareWithInfo:(NSDictionary *)info
    inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSString *identifier = [info objectForKey:@"id"];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CLASS_NAME_SHARE];
    request.predicate = [NSPredicate predicateWithFormat:@"identifier = %@", identifier];
    
    DTShare *share = nil;
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (error || !matches || [matches count] > 1) {
        //handle error
    } else {
        if ([matches count]) {
            share = [matches firstObject];
        } else {
            share = [NSEntityDescription insertNewObjectForEntityForName:CLASS_NAME_SHARE inManagedObjectContext:context];
        }
        
        //TODO attributes
        share.amount = [info objectForKey:@"amount"];
    }
    
    return share;
}

+ (NSArray *)sharesWithArray:(NSArray *)arrayInfo
{
    NSMutableArray *tempShares = [[NSMutableArray alloc] init];
    for (NSDictionary *info in arrayInfo) {
        DTShare *share = [DTShare shareWithInfo:info];
        [tempShares addObject:share];
    }
    return tempShares;
}

@end
