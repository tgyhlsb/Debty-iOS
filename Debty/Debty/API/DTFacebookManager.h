//
//  DTFacebookManager.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 05/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

#define FACEBOOK_PERMISSIONS @[@"public_profile", @"email", @"user_friends"]

@interface DTFacebookManager : NSObject

+ (void)fetchFriendsWithCompletionHandler:(FBRequestHandler)completionHandler;
+ (NSString *)facebookIDForUser:(id<FBGraphUser>)user;
+ (NSArray *)facebookIDForUserArray:(NSArray *)users;

+ (void)logOut;
+ (void)logIn;
+ (BOOL)isSessionOpen;

+ (void)handleAppColdStart;

@end
