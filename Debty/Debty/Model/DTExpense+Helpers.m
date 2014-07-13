//
//  DTExpense+Helpers.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTExpense+Helpers.h"

@implementation DTExpense (Helpers)

- (BOOL)safeNeedSync
{
    return [self.needSync boolValue];
}

@end
