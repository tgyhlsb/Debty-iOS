//
//  DTExpense+Serializer.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 21/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTExpense+Serializer.h"
#import "DTModelManager.h"

@implementation DTExpense (Serializer)

+ (DTExpense *)expenseWithInfo:(NSDictionary *)info
{
    return [DTExpense expenseWithInfo:info
               inManagedObjectContext:[DTModelManager sharedContext]];
}

+ (DTExpense *)expenseWithInfo:(NSDictionary *)info
        inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSString *identifier = [info objectForKey:@"id"];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CLASS_NAME_EXPENSE];
    request.predicate = [NSPredicate predicateWithFormat:@"identifier = %@", identifier];
    
    DTExpense *expense = nil;
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (error || !matches || [matches count] > 1) {
        //handle error
    } else {
        if ([matches count]) {
            expense = [matches firstObject];
        } else {
            expense = [NSEntityDescription insertNewObjectForEntityForName:CLASS_NAME_EXPENSE inManagedObjectContext:context];
        }
        
        //TODO attributes
        expense.amount = [info objectForKey:@"amount"];
    }
    
    return expense;
}

+ (NSArray *)expensesWithArray:(NSArray *)arrayInfo
{
    NSMutableArray *tempExpenses = [[NSMutableArray alloc] init];
    for (NSDictionary *info in arrayInfo) {
        DTExpense *expense = [DTExpense expenseWithInfo:info];
        [tempExpenses addObject:expense];
    }
    return tempExpenses;
}

+ (DTExpense *)newExpenseWithAccount:(DTAccount *)account
{
    return [DTExpense expenseWithAccount:account inManagedObjectContext:[DTModelManager sharedContext]];
}

+ (DTExpense *)expenseWithAccount:(DTAccount *)account
           inManagedObjectContext:(NSManagedObjectContext *)context
{
    
    DTExpense *expense = [NSEntityDescription insertNewObjectForEntityForName:CLASS_NAME_EXPENSE inManagedObjectContext:context];
    
    [expense setAccount:account];
    [expense setShares:[[NSSet alloc] init]];
    
    return expense;
}


@end
