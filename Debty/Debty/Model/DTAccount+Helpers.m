//
//  DTAccount+Helpers.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 11/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTAccount+Helpers.h" 
#import "DTPerson.h"

@implementation DTAccount (Helpers)

- (NSNumber *)balanceForPerson:(DTPerson *)person
{
    return @2.0;
}

- (NSString *)safeName
{
    if (!self.name) {
        NSString *composedName = @"";
        for (DTPerson *person in self.persons) {
            composedName = [composedName stringByAppendingFormat:@"%@ ", person.firstName];
        }
        return composedName;
    }
    return self.name;
}

@end
