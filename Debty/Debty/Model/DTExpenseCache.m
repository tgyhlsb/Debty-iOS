//
//  DTExpenseCache.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 09/10/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTExpenseCache.h"
#import "DTModelManager.h"

@interface DTExpenseCache()

@property (strong, nonatomic) DTExpense *expense;

@end

@implementation DTExpenseCache

#pragma mark - Loading and saving expense

- (void)loadFromExpense:(DTExpense *)expense
{
    self.expense = expense;
    
    self.name = expense.name;
    self.amount = expense.amount;
    self.whoPayed = expense.whoPayed;
    self.payDate = expense.date;
    
    self.personAndValueMapping = [self getPersonAndValueMappingFromExpense:expense];
}

- (void)saveToExpense:(DTExpense *)expense
{
    self.expense.name = self.name;
    self.expense.amount = self.amount;
    self.expense.whoPayed = self.whoPayed;
    self.expense.date = self.payDate;
    
    [self setExpense:expense withPersonAndValueMapping:self.personAndValueMapping];
}

#pragma mark - Data manipulation



- (void)setExpense:(DTExpense *)expense withPersonAndValueMapping:(NSMapTable *)mapTable
{
    NSEnumerator *personEnumerator = [mapTable keyEnumerator];
    DTPerson *person = nil;
    DTShare *share = nil;
    while (person = [personEnumerator nextObject]) {
        share = [expense shareForPerson:person];
        share.value = [mapTable objectForKey:person];
    }
}

- (NSMapTable *)getPersonAndValueMappingFromExpense:(DTExpense *)expense
{
    NSMapTable *mapTable = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory
                                                 valueOptions:NSPointerFunctionsStrongMemory];
    for (DTShare *share in expense.shares) {
        [mapTable setObject:share.value forKey:share.person];
    }
    return mapTable;
}

#pragma mark - CoreData

- (NSFetchedResultsController *)fetchResultControllerForAvailablePersons
{
    return [DTModelManager fetchResultControllerForPersonInAccount:self.expense.account];
}

@end
