//
//  DTShare+Helpers.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTShare.h"

typedef NS_ENUM(NSInteger, DTShareType) {
    DTShareTypeEqually,
    DTShareTypeExactly,
    DTShareTypePercent,
    DTShareTypeShare
};

@interface DTShare (Helpers)

- (NSDecimalNumber *)dueAmount;
- (NSDecimalNumber *)paidAmount;
- (NSDecimalNumber *)balancedAmount;

@end
