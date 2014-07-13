//
//  DTInstallation.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 06/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTInstallation.h"
#import "DTAppDelegate.h"
#import "DTModelManager.h"
#import "DTBackendManager.h"
#import "DTFacebookManager.h"
#import "DTPerson+Serializer.h"

#define MAINUSER_IDENTIFIER_KEY @"mainUserIdentifier"

static DTInstallation *sharedInstallation;

@interface DTInstallation()

@property (strong, nonatomic) NSNumber *meIdentifier;

@property (strong, nonatomic) DTPerson *me;

@property (nonatomic) DTUserState userState;

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

@synthesize meIdentifier = _meIdentifier;

- (void)setMeIdentifier:(NSNumber *)mainUserIdentifier
{
    _meIdentifier = mainUserIdentifier;
    [[NSUserDefaults standardUserDefaults] setObject:mainUserIdentifier forKey:MAINUSER_IDENTIFIER_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSNumber *)meIdentifier
{
    if (!_meIdentifier) {
        _meIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey:MAINUSER_IDENTIFIER_KEY];
    }
    return _meIdentifier;
}

@synthesize me = _me;

- (void)setMe:(DTPerson *)me
{
    self.meIdentifier = me.identifier;
    _me = me;
}

- (DTPerson *)me
{
    if (!_me) {
        NSFetchedResultsController *fetchedResultController = [DTModelManager fetchResultControllerForPersonsWithIdentifier:self.meIdentifier];
        
        NSError *error = nil;
        [fetchedResultController performFetch:&error];
        
        if (error) {
            NSLog(@"[DTInstallation mainUser]\n%@", error);
        } else {
            _me = [[fetchedResultController fetchedObjects] lastObject];
        }
    }
    return _me;
}

+ (void)setMe:(DTPerson *)me
{
    [[DTInstallation sharedInstallation] setMe:me];
}

+ (DTPerson *)me
{
    return [[DTInstallation sharedInstallation] me];
}

+ (void)setMeWithInfo:(NSDictionary *)info
{
    DTPerson *user = [DTPerson personWithInfo:info];
    [DTInstallation setMe:user];
}

#pragma mark - Basic Auth credentials

+ (NSString *)authIdentifier
{
    return [[DTInstallation sharedInstallation] authIdentifier];
}

- (NSString *)authIdentifier
{
    return self.me.facebookID;
}

+ (NSString *)authPassword
{
    return [[DTInstallation sharedInstallation] authPassword];
}

- (NSString *)authPassword
{
    NSString *firstName = self.me.firstName;
    NSString *facebookHash = [self.me.facebookID substringToIndex:5];
    NSString *password = [firstName stringByAppendingString:facebookHash];
    
    CocoaSecurityResult *sha256 = [CocoaSecurity sha256:password];
    return [sha256.hex lowercaseString];
}

#pragma mark - Facebook actions

+ (void)loginWithFacebook
{
    [DTFacebookManager logInWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        [DTInstallation sharedInstallation].userState = DTUserStateFetchingInfo;
        [[DTInstallation sharedInstallation] facebookFetchedUserInfo:result];
    }];
}


+ (void)logoutFromFacebook
{
    [DTFacebookManager logOut];
    [DTInstallation sharedInstallation].userState = DTUserStateLoggedOut;
}


- (void)facebookFetchedUserInfo:(id<FBGraphUser>)user
{
    [DTBackendManager identifyUserWithGraph:user success:^(NSURLSessionDataTask *task, NSDictionary *json) {
        NSDictionary *userInfo = [json objectForKey:@"user"];
        [DTInstallation setMeWithInfo:userInfo];
        self.userState = DTUserStateLoggedIn;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - Lock/unlock Application

+ (void)unlockApplication
{
    [DTAppDelegate setLoggedIn];
}

+ (void)lockApplication
{
    [DTAppDelegate setLoggedOut];
}

+ (BOOL)canUnlockApplication
{
    return [DTFacebookManager isSessionAvailable];
}

#pragma mark - User State

+ (DTUserState)userState
{
    return [DTInstallation sharedInstallation].userState;
}

- (void)setUserState:(DTUserState)userState
{
    _userState = userState;
    [self notifyUserStateChanged];
}

- (void)notifyUserStateChanged
{
    [[NSNotificationCenter defaultCenter] postNotificationName:DTNotificationUserStateChanged object:nil];
}

@end
