//
//  DTPerson.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 21/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DTAccount, DTShare;

@interface DTPerson : NSManagedObject

@property (nonatomic, retain) NSDate * birthdate;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * facebookID;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * identifer;
@property (nonatomic, retain) NSSet *accounts;
@property (nonatomic, retain) NSSet *shares;
@end

@interface DTPerson (CoreDataGeneratedAccessors)

- (void)addAccountsObject:(DTAccount *)value;
- (void)removeAccountsObject:(DTAccount *)value;
- (void)addAccounts:(NSSet *)values;
- (void)removeAccounts:(NSSet *)values;

- (void)addSharesObject:(DTShare *)value;
- (void)removeSharesObject:(DTShare *)value;
- (void)addShares:(NSSet *)values;
- (void)removeShares:(NSSet *)values;

@end
