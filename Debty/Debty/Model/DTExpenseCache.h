//
//  DTExpenseCache.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 09/10/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTExpense+Helpers.h"
#import "DTPerson+Helpers.h"

@interface DTExpenseCache : NSObject


@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSDecimalNumber *amount;
@property (strong, nonatomic) DTPerson *whoPayed;
@property (strong, nonatomic) NSDate *payDate;
@property (strong, nonatomic) NSMapTable *personAndValueMapping;

- (void)loadFromExpense:(DTExpense *)expense;
- (void)saveToExpense:(DTExpense *)expense;

- (NSFetchedResultsController *)fetchResultControllerForAvailablePersons;





@end
