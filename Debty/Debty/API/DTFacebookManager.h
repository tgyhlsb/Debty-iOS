//
//  DTFacebookManager.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 05/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

@interface DTFacebookManager : NSObject

+ (void)fetchFriendsWithCompletionHandler:(FBRequestHandler)completionHandler;
+ (NSString *)facebookIDForUser:(id<FBGraphUser>)user;
+ (NSArray *)facebookIDForUserArray:(NSArray *)users;

@end
