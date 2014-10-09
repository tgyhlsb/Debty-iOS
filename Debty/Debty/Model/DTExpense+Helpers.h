//
//  DTExpense+Helpers.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTExpense.h"
#import "DTShare+Helpers.h"

@interface DTExpense (Helpers)

- (DTShareType)type;
- (void)setType:(DTShareType)type;

- (BOOL)safeNeedSync;
- (BOOL)safeIsValid;
- (NSDecimalNumber *)totalValue;

- (DTShare *)shareForPerson:(DTPerson *)person;

@end
