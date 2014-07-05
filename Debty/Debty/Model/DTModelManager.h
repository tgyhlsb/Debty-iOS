//
//  DTModelManager.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 15/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTPerson+Serializer.h"

@interface DTModelManager : NSObject

+ (NSManagedObjectContext *)sharedContext;

+ (void)getPersonSample;
+ (void)updateUser;


+ (NSFetchedResultsController *)fetchResultControllerForPersons;

@end
