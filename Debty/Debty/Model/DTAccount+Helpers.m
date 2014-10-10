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
#import "DTInstallation.h"
#import "DTOperationManager.h"

@implementation DTAccount (Helpers)

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

- (void)updateCache
{
    self.cachedBalance = [self myBalance];
}

@end
