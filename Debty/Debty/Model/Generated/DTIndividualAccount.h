//
//  DTIndividualAccount.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 14/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "DTAccount.h"

@class DTPerson;

@interface DTIndividualAccount : DTAccount

@property (nonatomic, retain) DTPerson *otherPerson;

@end
