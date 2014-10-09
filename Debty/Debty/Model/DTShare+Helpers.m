//
//  DTShare+Helpers.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTShare+Helpers.h"
#import "DTExpense+Helpers.h"
#import "DTPerson+Helpers.h"

@implementation DTShare (Helpers)

- (NSDecimalNumber *)dueAmount
{
    NSDecimalNumber *total = [self.expense totalValue];
    NSDecimalNumber *percent = [self.value decimalNumberByDividingBy:total];
    return [self.expense.amount decimalNumberByMultiplyingBy:percent];
}

- (NSDecimalNumber *)paidAmount
{
    if ([self.person isEqual:self.expense.whoPayed]) {
        return self.expense.amount;
    } else {
        return [NSDecimalNumber zero];
    }
}

- (NSDecimalNumber *)balancedAmount
{
    return [[self paidAmount] decimalNumberBySubtracting:[self dueAmount]];
}

@end
