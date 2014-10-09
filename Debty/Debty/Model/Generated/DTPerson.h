//
//  DTPerson.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 09/10/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DTAccount, DTExpense, DTPerson, DTShare;

@interface DTPerson : NSManagedObject

@property (nonatomic, retain) NSDate * birthdate;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * facebookID;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSNumber * isSelected;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * needSync;
@property (nonatomic, retain) NSSet *accounts;
@property (nonatomic, retain) NSSet *friends;
@property (nonatomic, retain) NSSet *friendsInverseRelation;
@property (nonatomic, retain) NSSet *payedFor;
@property (nonatomic, retain) NSSet *shares;
@end

@interface DTPerson (CoreDataGeneratedAccessors)

- (void)addAccountsObject:(DTAccount *)value;
- (void)removeAccountsObject:(DTAccount *)value;
- (void)addAccounts:(NSSet *)values;
- (void)removeAccounts:(NSSet *)values;

- (void)addFriendsObject:(DTPerson *)value;
- (void)removeFriendsObject:(DTPerson *)value;
- (void)addFriends:(NSSet *)values;
- (void)removeFriends:(NSSet *)values;

- (void)addFriendsInverseRelationObject:(DTPerson *)value;
- (void)removeFriendsInverseRelationObject:(DTPerson *)value;
- (void)addFriendsInverseRelation:(NSSet *)values;
- (void)removeFriendsInverseRelation:(NSSet *)values;

- (void)addPayedForObject:(DTExpense *)value;
- (void)removePayedForObject:(DTExpense *)value;
- (void)addPayedFor:(NSSet *)values;
- (void)removePayedFor:(NSSet *)values;

- (void)addSharesObject:(DTShare *)value;
- (void)removeSharesObject:(DTShare *)value;
- (void)addShares:(NSSet *)values;
- (void)removeShares:(NSSet *)values;

@end
