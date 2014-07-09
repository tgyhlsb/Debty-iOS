//
//  DTInstallation.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 06/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTPerson.h"

static NSString *DTNotificationUserStateChanged = @"DTNotificationUserStateChanged";

typedef NS_ENUM(NSInteger, DTUserState) {
    DTUserStateLoggedOut,
    DTUserStateLoggedIn,
    DTUserStateFetchingInfo
};

@interface DTInstallation : NSObject

+ (DTPerson *)mainUser;
+ (void)setMainUser:(DTPerson *)mainUser;
+ (void)setMainUserWithInfo:(NSDictionary *)info;

+ (DTUserState)userState;
+ (void)loginWithFacebook;
+ (void)logoutFromFacebook;

+ (void)unlockApplication;
+ (void)lockApplication;
+ (BOOL)canUnlockApplication;

+ (NSString *)authIdentifier;
+ (NSString *)authPassword;

@end
