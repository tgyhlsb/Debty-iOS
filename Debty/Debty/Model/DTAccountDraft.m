//
//  DTAccountDraft.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 09/10/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTAccountDraft.h"
#import "DTInstallation.h"
#import "DTModelManager.h"

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

- (NSString *)defaultName
{
    NSString *composedName = @"";
    for (DTPerson *person in self.personList) {
        if (![person isEqual:[DTInstallation me]]) {
            composedName = [composedName stringByAppendingFormat:@"%@ ", person.firstName];
        }
    }
    return composedName;
}

#pragma mark - Load and Save draft

- (void)loadFromAccount:(DTAccount *)account
{
    self.account = account;
    self.name = account.name;
    self.localeCode = account.localeCode;
}

- (DTAccount *)accountFromDraft
{
    NSMutableArray *realPersonList = [self.personList mutableCopy];
    [realPersonList addObject:[DTInstallation me]];
    DTAccount *account = [DTModelManager newAccountWithPersons:realPersonList];
    account.name = self.name;
    account.localeCode = self.localeCode;
    
    return account;
}

#pragma mark - Getters & Setters

- (NSString *)name
{
    if (!_name) {
        _name = [self defaultName];
    }
    return _name;
}

- (NSString *)localeCode
{
    if (!_localeCode) {
        _localeCode = [[NSLocale currentLocale] localeIdentifier];
    }
    return _localeCode;
}

@end
