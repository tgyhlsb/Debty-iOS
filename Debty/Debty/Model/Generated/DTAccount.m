//
//  DTAccount.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 09/10/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTAccount.h"
#import "DTExpense.h"
#import "DTPerson.h"


@implementation DTAccount

@dynamic identifier;
@dynamic name;
@dynamic needSync;
@dynamic cachedBalance;
@dynamic localeCode;
@dynamic expenses;
@dynamic persons;

@end
