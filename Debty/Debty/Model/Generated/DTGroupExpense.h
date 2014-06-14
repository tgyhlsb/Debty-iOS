//
//  DTGroupExpense.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 14/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DTGroupExpense : NSManagedObject

@property (nonatomic, retain) NSSet *debtors;
@property (nonatomic, retain) NSManagedObject *creditor;
@end

@interface DTGroupExpense (CoreDataGeneratedAccessors)

- (void)addDebtorsObject:(NSManagedObject *)value;
- (void)removeDebtorsObject:(NSManagedObject *)value;
- (void)addDebtors:(NSSet *)values;
- (void)removeDebtors:(NSSet *)values;

@end
