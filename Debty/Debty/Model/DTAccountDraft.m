//
//  DTAccountDraft.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 09/10/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTAccountDraft.h"

@interface DTAccountDraft()

@property (strong, nonatomic) DTAccount *account;

@end

@implementation DTAccountDraft

+ (DTAccountDraft *)emptyDraft
{
    return [[DTAccountDraft alloc] init];
}

+ (DTAccountDraft *)draftFromAccount:(DTAccount *)account
{
    DTAccountDraft *draft = [[DTAccountDraft alloc] init];
    [draft loadFromAccount:account];
    return draft;
}

#pragma mark - Load and Save draft

- (void)loadFromAccount:(DTAccount *)account
{
    self.account = account;
    self.name = account.name;
    self.localeCode = account.localeCode;
}

- (void)saveToAccount:(DTAccount *)account
{
    account.name = self.name;
    account.localeCode = self.localeCode;
}

#pragma mark - Getters & Setters

@end
