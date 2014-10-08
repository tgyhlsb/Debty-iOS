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

- (void)setSharesFromPersonAndValueMapping:(NSMapTable *)mapTable andType:(DTShareType)type
{
    [self setType:type];
    switch (type) {
        case DTShareTypeEqually:
        {
            
            break;
        }
            
        case DTShareTypeExactly:
        {
            NSEnumerator *personEnumerator = [mapTable keyEnumerator];
            DTPerson *person = nil;
            DTShare *share = nil;
            while (person = [personEnumerator nextObject]) {
                share = [self shareForPerson:person];
                share.value = [mapTable objectForKey:person];
                NSLog(@"%@", share.value);
            }
            break;
        }
            
        case DTShareTypePercent:
        {
            NSDecimalNumber *totalPayed = [NSDecimalNumber decimalNumberWithString:@"0.00"];
            NSDecimalNumber *totalToPay = [NSDecimalNumber decimalNumberWithString:@"100.00"];
            
            NSEnumerator *personEnumerator = [mapTable keyEnumerator];
            DTPerson *person = nil;
            DTShare *share = nil;
            while (person = [personEnumerator nextObject]) {
                share = [self shareForPerson:person];
                CGFloat percent = [[mapTable objectForKey:person] floatValue];
                NSString *stringPercent = [NSString stringWithFormat:@"%.2f", percent];
                NSLog(@"percent = %@", stringPercent);
                share.value = [[NSDecimalNumber alloc] initWithString:stringPercent];
                totalPayed = [totalPayed decimalNumberByAdding:share.value];
                NSLog(@"%@", share.value);
            }
            
            NSDecimalNumber *missing = [totalToPay decimalNumberBySubtracting:totalPayed];
            share.value = [share.value decimalNumberByAdding:missing];
            NSLog(@"-> %@", share.value);
            
            break;
        }
            
        case DTShareTypeShare:
        {
            
            break;
        }
            
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
