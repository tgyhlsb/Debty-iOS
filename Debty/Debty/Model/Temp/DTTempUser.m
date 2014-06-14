//
//  DTTempUser.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 14/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTTempUser.h"

static DTTempUser *sharedUser;

@implementation DTTempUser

+ (DTTempUser *)sharedUser
{
    if (!sharedUser) {
        sharedUser = [[DTTempUser alloc] init];
    }
    return sharedUser;
}

+ (void)setWithFacebookUser:(id<FBGraphUser>)facebookUser
{
    [[DTTempUser sharedUser] setWithFacebookUser:facebookUser];
}

- (void)setWithFacebookUser:(id<FBGraphUser>)facebookUser
{
    if (facebookUser) {
        self.firstName = facebookUser.first_name;
        self.lastName = facebookUser.last_name;
        self.facebookID = facebookUser.objectID;
        self.facebookLocale = [facebookUser objectForKey:@"locale"];
        self.email = [facebookUser objectForKey:@"email"];
        self.birthday = facebookUser.birthday;
        
        [self fetchFriends];
    }
}

+ (void)fetchFriends
{
    [[DTTempUser sharedUser] fetchFriends];
}

- (void)fetchFriends
{
    FBRequest *friendRequest = [FBRequest requestForMyFriends];
    [friendRequest startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        NSLog(@"%@", result);
        NSLog(@"%@", error);
    }];
}

@end
