//
//  DTAccount.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 21/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DTExpense, DTPerson;

@interface DTAccount : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *persons;
@property (nonatomic, retain) NSSet *expenses;
@end

@interface DTAccount (CoreDataGeneratedAccessors)

- (void)addPersonsObject:(DTPerson *)value;
- (void)removePersonsObject:(DTPerson *)value;
- (void)addPersons:(NSSet *)values;
- (void)removePersons:(NSSet *)values;

- (void)addExpensesObject:(DTExpense *)value;
- (void)removeExpensesObject:(DTExpense *)value;
- (void)addExpenses:(NSSet *)values;
- (void)removeExpenses:(NSSet *)values;

@end
