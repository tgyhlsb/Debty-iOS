//
//  DTExpense+Helpers.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTExpense+Helpers.h"

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

@end
