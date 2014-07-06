//
//  DTPerson+Serializer.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 15/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTPerson.h"

#define CLASS_NAME_PERSON @"DTPerson"

#define MAIN_USER_KEY @"isMainUser"

@interface DTPerson (Serializer)

- (NSArray *)friendsArray;

+ (DTPerson *)personWithInfo:(NSDictionary *)info;
+ (NSArray *)personsWithArray:(NSArray *)arrayInfo;

@end
