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
#import "DTOperationManager.h"
#import "DTInstallation.h"

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

- (NSDecimalNumber *)totalValue
{
    NSDecimalNumber *total = [NSDecimalNumber zero];
    for (DTShare *share in self.shares) {
        total = [DTOperationManager add:share.value to:total];
    }
    return total;
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

- (NSDecimalNumber *)myBalance
{
    if ([self safeIsValid]) {
        DTShare *myShare = [self shareForPerson:[DTInstallation me]];
        return [myShare balancedAmount];
    } else {
        return [NSDecimalNumber zero];
    }
}

@end
