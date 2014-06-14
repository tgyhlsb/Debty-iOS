//
//  DTIndividualExpense.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 14/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DTIndividualExpense : NSManagedObject

@property (nonatomic, retain) NSNumber * isOwner;
@property (nonatomic, retain) NSNumber * isDebtor;
@property (nonatomic, retain) NSNumber * valid;

@end
