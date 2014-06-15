//
//  DTAccount.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 14/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DTExpense;

@interface DTAccount : NSManagedObject

@property (nonatomic, retain) NSSet *expenses;
@end

@interface DTAccount (CoreDataGeneratedAccessors)

- (void)addExpensesObject:(DTExpense *)value;
- (void)removeExpensesObject:(DTExpense *)value;
- (void)addExpenses:(NSSet *)values;
- (void)removeExpenses:(NSSet *)values;

@end
