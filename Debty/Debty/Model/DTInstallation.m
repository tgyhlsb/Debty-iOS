//
//  DTInstallation.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 06/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTInstallation.h"
#import "DTModelManager.h"

#define MAINUSER_IDENTIFIER_KEY @"mainUserIdentifier"

static DTInstallation *sharedInstallation;

@interface DTInstallation()

@property (strong, nonatomic) NSNumber *mainUserIdentifier;

@property (strong, nonatomic) DTPerson *mainUser;

@end

@implementation DTInstallation

+ (DTInstallation *)sharedInstallation
{
    if (!sharedInstallation) {
        sharedInstallation = [[DTInstallation alloc] init];
    }
    return sharedInstallation;
}

#pragma mark - Main User

@synthesize mainUserIdentifier = _mainUserIdentifier;

- (void)setMainUserIdentifier:(NSNumber *)mainUserIdentifier
{
    _mainUserIdentifier = mainUserIdentifier;
    [[NSUserDefaults standardUserDefaults] setObject:mainUserIdentifier forKey:MAINUSER_IDENTIFIER_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSNumber *)mainUserIdentifier
{
    if (!_mainUserIdentifier) {
        _mainUserIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey:MAINUSER_IDENTIFIER_KEY];
    }
    return _mainUserIdentifier;
}

@synthesize mainUser = _mainUser;

- (void)setMainUser:(DTPerson *)mainUser
{
    self.mainUserIdentifier = mainUser.identifier;
    _mainUser = mainUser;
}

- (DTPerson *)mainUser
{
    if (!_mainUser) {
        NSFetchedResultsController *fetchedResultController = [DTModelManager fetchResultControllerForPersonsWithIdentifier:self.mainUserIdentifier];
        
        NSError *error = nil;
        [fetchedResultController performFetch:&error];
        
        if (error) {
            NSLog(@"[DTInstallation mainUser]\n%@", error);
        } else {
            _mainUser = [[fetchedResultController fetchedObjects] lastObject];
        }
    }
    return _mainUser;
}

+ (void)setMainUser:(DTPerson *)mainUser
{
    [[DTInstallation sharedInstallation] setMainUser:mainUser];
}

+ (DTPerson *)mainUser
{
    return [[DTInstallation sharedInstallation] mainUser];
}

+ (void)setMainUserWithInfo:(NSDictionary *)info
{
    DTPerson *user = [DTPerson personWithInfo:info];
    [DTInstallation setMainUser:user];
}

#pragma mark - Basic Auth credentials

+ (NSString *)authIdentifier
{
    return [[DTInstallation sharedInstallation] authIdentifier];
}

- (NSString *)authIdentifier
{
    return self.mainUser.facebookID;
}

+ (NSString *)authPassword
{
    return [[DTInstallation sharedInstallation] authPassword];
}

- (NSString *)authPassword
{
    NSString *firstName = self.mainUser.firstName;
    NSString *facebookHash = [self.mainUser.facebookID substringToIndex:5];
    NSString *password = [firstName stringByAppendingString:facebookHash];
    
    CocoaSecurityResult *sha256 = [CocoaSecurity sha256:password];
    return [sha256.hex lowercaseString];
}

@end
