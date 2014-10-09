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
#import "DTOperationManager.h"

@implementation DTShare (Helpers)

- (NSDecimalNumber *)dueAmount
{
    NSDecimalNumber *total = [self.expense totalValue];
    NSDecimalNumber *percent = [DTOperationManager divide:self.value by:total];
    NSDecimalNumber *exactAmount = [DTOperationManager multiply:self.expense.amount by:percent];
    return [DTOperationManager roundedNumber:exactAmount];
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
    return [DTOperationManager substract:[self dueAmount] to:[self paidAmount]];
}

@end
