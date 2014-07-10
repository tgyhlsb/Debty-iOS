//
//  DTAccount+Serializer.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 21/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTAccount.h"

#define CLASS_NAME_ACCOUNT @"DTAccount"

@interface DTAccount (Serializer)

+ (DTAccount *)accountWithInfo:(NSDictionary *)info;
+ (NSArray *)accountsWithArray:(NSArray *)arrayInfo;

- (NSNumber *)balanceForPerson:(DTPerson *)person;


@end
