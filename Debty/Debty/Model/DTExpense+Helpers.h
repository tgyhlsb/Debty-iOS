//
//  DTExpense+Helpers.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTExpense.h"

@interface DTExpense (Helpers)

- (BOOL)safeNeedSync;
- (BOOL)safeIsValid;

@end
