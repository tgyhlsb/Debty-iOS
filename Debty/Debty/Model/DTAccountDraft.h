//
//  DTAccountDraft.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 09/10/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTAccount+Helpers.h"

@interface DTAccountDraft : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *localeCode;
@property (strong, nonatomic) NSArray *personList;

+ (DTAccountDraft *)emptyDraft;
+ (DTAccountDraft *)draftFromAccount:(DTAccount *)account;

- (void)loadFromAccount:(DTAccount *)account;
- (DTAccount *)accountFromDraft;

@end
