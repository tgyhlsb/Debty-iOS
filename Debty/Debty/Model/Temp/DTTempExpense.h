//
//  DTTempExpense.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTTempFriend.h"

@interface DTTempExpense : NSObject

@property (nonatomic, strong) DTTempFriend *friend;
@property (nonatomic, strong) NSNumber *price;

+ (DTTempExpense *)randomExpense;

@end
