//
//  DTExpense+Serializer.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 21/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTExpense.h"

#define CLASS_NAME_EXPENSE @"DTExpense"

@interface DTExpense (Serializer)

+ (DTExpense *)expenseWithInfo:(NSDictionary *)info;
+ (DTExpense *)expensesWithArray:(NSArray *)arrayInfo;

@end
