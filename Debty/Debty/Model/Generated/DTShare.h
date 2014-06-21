//
//  DTShare.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 21/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DTExpense, DTPerson;

@interface DTShare : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * amount;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) DTExpense *expense;
@property (nonatomic, retain) DTPerson *person;

@end
