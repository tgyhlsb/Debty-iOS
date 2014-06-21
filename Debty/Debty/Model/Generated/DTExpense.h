//
//  DTExpense.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 21/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DTAccount, DTShare;

@interface DTExpense : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * amount;
@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSSet *shares;
@property (nonatomic, retain) DTAccount *account;
@end

@interface DTExpense (CoreDataGeneratedAccessors)

- (void)addSharesObject:(DTShare *)value;
- (void)removeSharesObject:(DTShare *)value;
- (void)addShares:(NSSet *)values;
- (void)removeShares:(NSSet *)values;

@end
