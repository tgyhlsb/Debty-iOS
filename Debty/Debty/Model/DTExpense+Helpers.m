//
//  DTExpense+Helpers.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTExpense+Helpers.h"
#import "DTPerson+Helpers.h"
#import "DTShare+Serializer.h"

@implementation DTExpense (Helpers)

- (DTShareType)type
{
    return [self.intType intValue];
}

- (void)setType:(DTShareType)type
{
    self.intType = [NSNumber numberWithInt:type];
}

- (BOOL)safeNeedSync
{
    return self.needSync ? [self.needSync boolValue] : NO;
}

- (BOOL)safeIsValid
{
    return self.isValid ? [self.isValid boolValue] : NO;
}

- (DTShare *)shareForPerson:(DTPerson *)person
{
    for (DTShare *share in self.shares) {
        if ([share.person isEqual:person]) {
            return share;
        }
    }
    return [DTShare shareForExpense:self andPerson:person];
}

- (void)setSharesFromPersonAndValueMapping:(NSMapTable *)mapTable
{
    NSEnumerator *personEnumerator = [mapTable keyEnumerator];
    DTPerson *person = nil;
    DTShare *share = nil;
    while (person = [personEnumerator nextObject]) {
        share = [self shareForPerson:person];
        share.value = [mapTable objectForKey:person];
    }
}

- (NSMapTable *)getPersonAndValueMapping
{
    NSMapTable *mapTable = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory
                                                 valueOptions:NSPointerFunctionsStrongMemory];
    for (DTShare *share in self.shares) {
        [mapTable setObject:share.value forKey:share.person];
    }
    return mapTable;
}

@end
