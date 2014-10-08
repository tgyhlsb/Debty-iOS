//
//  DTExpense.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 08/10/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DTAccount, DTPerson, DTShare;

@interface DTExpense : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * amount;
@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSNumber * intType;
@property (nonatomic, retain) NSNumber * isValid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * needSync;
@property (nonatomic, retain) DTAccount *account;
@property (nonatomic, retain) NSSet *shares;
@property (nonatomic, retain) DTPerson *whoPayed;
@end

@interface DTExpense (CoreDataGeneratedAccessors)

- (void)addSharesObject:(DTShare *)value;
- (void)removeSharesObject:(DTShare *)value;
- (void)addShares:(NSSet *)values;
- (void)removeShares:(NSSet *)values;

@end
