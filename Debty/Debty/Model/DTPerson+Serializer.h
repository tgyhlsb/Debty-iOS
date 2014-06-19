//
//  DTPerson+Serializer.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 15/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTPerson.h"

#define CLASS_NAME_PERSON @"DTPerson"

@interface DTPerson (Serializer)

+ (DTPerson *)personWithInfo:(NSDictionary *)info;
+ (NSArray *)personsWithArray:(NSArray *)arrayInfo;

@end
