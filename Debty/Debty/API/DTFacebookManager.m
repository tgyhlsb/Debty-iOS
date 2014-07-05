//
//  DTFacebookManager.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 05/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTFacebookManager.h"

@implementation DTFacebookManager

+ (void)fetchFriendsWithCompletionHandler:(FBRequestHandler)completionHandler
{
    FBRequest *friendRequest = [FBRequest requestForMyFriends];
    [friendRequest startWithCompletionHandler:completionHandler];
}

+ (NSString *)facebookIDForUser:(id<FBGraphUser>)user
{
    return @"";
}

+ (NSArray *)facebookIDForUserArray:(NSArray *)users
{
    NSMutableArray *tempIDs = [[NSMutableArray alloc] init];
    for (id<FBGraphUser> user in users) {
        [tempIDs addObject:[DTFacebookManager facebookIDForUser:user]];
    }
    return tempIDs;
}

@end
