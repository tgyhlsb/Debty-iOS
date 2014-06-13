//
//  DTTempExpense.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTTempExpense.h"

@implementation DTTempExpense

+ (DTTempExpense *)randomExpense
{
    DTTempExpense *expense = [[DTTempExpense alloc] init];
    expense.price = [NSNumber numberWithFloat:(arc4random() % 100)/3.7];
    expense.userName = @"Manu";
    return expense;
}

@end
