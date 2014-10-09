//
//  DTAccount+Helpers.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 11/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTAccount+Helpers.h" 
#import "DTPerson+Helpers.h"
#import "DTExpense+Helpers.h"
#import "DTOperationManager.h"

@implementation DTAccount (Helpers)

- (NSString *)safeName
{
    if (!self.name) {
        NSString *composedName = @"";
        for (DTPerson *person in self.persons) {
            composedName = [composedName stringByAppendingFormat:@"%@ ", person.firstName];
        }
        return composedName;
    }
    return self.name;
}

- (BOOL)safeNeedSync
{
    return [self.needSync boolValue];
}

- (NSDecimalNumber *)myBalance
{
    NSDecimalNumber *totalBalance = [NSDecimalNumber zero];
    for (DTExpense *expense in self.expenses) {
        totalBalance = [DTOperationManager add:[expense myBalance] to:totalBalance];
    }
    return totalBalance;
}

@end
