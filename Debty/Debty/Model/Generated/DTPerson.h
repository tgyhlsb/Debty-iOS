//
//  DTPerson.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 14/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DTAccount, DTGroupAccount, DTGroupExpense;

@interface DTPerson : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSDate * birthdate;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * facebookID;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) DTAccount *individualAccount;
@property (nonatomic, retain) NSSet *groupAccounts;
@property (nonatomic, retain) NSSet *debtorGroupExpenseList;
@property (nonatomic, retain) NSSet *creditorGroupExpenseList;
@end

@interface DTPerson (CoreDataGeneratedAccessors)

- (void)addGroupAccountsObject:(DTGroupAccount *)value;
- (void)removeGroupAccountsObject:(DTGroupAccount *)value;
- (void)addGroupAccounts:(NSSet *)values;
- (void)removeGroupAccounts:(NSSet *)values;

- (void)addDebtorGroupExpenseListObject:(DTGroupExpense *)value;
- (void)removeDebtorGroupExpenseListObject:(DTGroupExpense *)value;
- (void)addDebtorGroupExpenseList:(NSSet *)values;
- (void)removeDebtorGroupExpenseList:(NSSet *)values;

- (void)addCreditorGroupExpenseListObject:(DTGroupExpense *)value;
- (void)removeCreditorGroupExpenseListObject:(DTGroupExpense *)value;
- (void)addCreditorGroupExpenseList:(NSSet *)values;
- (void)removeCreditorGroupExpenseList:(NSSet *)values;

@end
