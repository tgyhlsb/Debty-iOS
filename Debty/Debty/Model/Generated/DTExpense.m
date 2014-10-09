//
//  DTExpense.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 09/10/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTExpense.h"
#import "DTAccount.h"
#import "DTPerson.h"
#import "DTShare.h"


@implementation DTExpense

@dynamic amount;
@dynamic creationDate;
@dynamic date;
@dynamic identifier;
@dynamic intType;
@dynamic isValid;
@dynamic name;
@dynamic needSync;
@dynamic cachedBalance;
@dynamic account;
@dynamic shares;
@dynamic whoPayed;

@end
