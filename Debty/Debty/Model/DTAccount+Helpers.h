//
//  DTAccount+Helpers.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 11/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTAccount.h"

@interface DTAccount (Helpers)

- (NSNumber *)balanceForPerson:(DTPerson *)person;
- (NSString *)safeName;

@end
