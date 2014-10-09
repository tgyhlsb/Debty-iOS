//
//  DTExpenseCache.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 09/10/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTExpenseCache.h"
#import "DTModelManager.h"

@interface DTExpenseCache() <NSCopying>

@property (strong, nonatomic) DTExpense *expense;


@end

@implementation DTExpenseCache

+ (DTExpenseCache *)cacheFromExpense:(DTExpense *)expense
{
    DTExpenseCache *cache = [[DTExpenseCache alloc] init];
    [cache loadFromExpense:expense];
    return cache;
}

- (void)setShareType:(DTShareType)shareType
{
    if (_shareType != shareType) {
        self.personAndValueMapping = nil;
    }
    
    _shareType = shareType;
}


- (NSMapTable *)personAndValueMapping
{
    if (!_personAndValueMapping) {
        _personAndValueMapping = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory
                                                         valueOptions:NSPointerFunctionsStrongMemory];
    }
    return _personAndValueMapping;
}

#pragma mark - Loading and saving expense

- (void)loadFromExpense:(DTExpense *)expense
{
    self.expense = expense;
    
    self.name = expense.name;
    self.amount = expense.amount;
    self.whoPayed = expense.whoPayed;
    self.payDate = expense.date;
    self.shareType = expense.type;
    
    self.personAndValueMapping = [self getPersonAndValueMappingFromExpense:expense];
}

- (void)saveToExpense:(DTExpense *)expense
{
    self.expense.name = self.name;
    self.expense.amount = self.amount;
    self.expense.whoPayed = self.whoPayed;
    self.expense.date = self.payDate;
    self.expense.type = self.shareType;
    
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

- (void)setPersonAndValueMapping:(NSMapTable *)mapTable withShareType:(DTShareType)shareType
{
    self.personAndValueMapping = mapTable;
    self.shareType = shareType;
}

#pragma mark - Values calculation

- (CGFloat)totalValue
{
    NSEnumerator *enumerator = [self.personAndValueMapping keyEnumerator];
    DTPerson *key = nil;
    NSDecimalNumber *value = nil;
    CGFloat total = 0;
    
    while ((key = [enumerator nextObject])) {
        value = [self.personAndValueMapping objectForKey:key];
        total += [value floatValue];
    }
    return total;
}

- (CGFloat)errorValue
{
    switch (self.shareType) {
        case DTShareTypeEqually:
            return [self totalValue] > 0 ? 0.0 : 1.0;
            
        case DTShareTypeExactly:
            return [self.amount floatValue] - [self totalValue];
            
        case DTShareTypePercent:
            return 100.0 - [self totalValue];
            
        case DTShareTypeShare:
            return [self totalValue] ? 0.0 : 1.0;
    }
}

- (BOOL)areSharesValid
{
    return ([self errorValue] == 0.0);
}

- (NSInteger)numberOfShares
{
    return [self.personAndValueMapping count];
}

#pragma mark - CoreData

- (NSFetchedResultsController *)fetchResultControllerForAvailablePersons
{
    return [DTModelManager fetchResultControllerForPersonInAccount:self.expense.account];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    DTExpenseCache *copy = [[DTExpenseCache allocWithZone:zone] init];
    copy.expense = self.expense;
    copy.name =  self.name;
    copy.amount = self.amount;
    copy.whoPayed = self.whoPayed;
    copy.payDate = self.payDate;
    copy.shareType = self.shareType;
    copy.personAndValueMapping = [self.personAndValueMapping copyWithZone:zone];
    
    return copy;
}

@end
