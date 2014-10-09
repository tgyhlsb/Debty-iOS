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
#import "DTShare+Helpers.h"

@interface DTExpenseCache : NSObject


@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSDecimalNumber *amount;
@property (strong, nonatomic) DTPerson *whoPayed;
@property (strong, nonatomic) NSDate *payDate;
@property (nonatomic) DTShareType shareType;
@property (strong, nonatomic) NSMapTable *personAndValueMapping;


+ (DTExpenseCache *)cacheFromExpense:(DTExpense *)expense;

- (void)loadFromExpense:(DTExpense *)expense;
- (void)saveToExpense:(DTExpense *)expense;
- (NSFetchedResultsController *)fetchResultControllerForAvailablePersons;

- (CGFloat)totalValue;
- (CGFloat)errorValue;
- (BOOL)areSharesValid;
- (NSInteger)numberOfShares;





@end
