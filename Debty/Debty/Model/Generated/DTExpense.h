//
//  DTExpense.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 14/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DTAccount;

@interface DTExpense : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * price;
@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) DTAccount *account;

@end
