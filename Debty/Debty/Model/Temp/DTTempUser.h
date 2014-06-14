//
//  DTTempUser.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 14/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

@interface DTTempUser : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *facebookID;
@property (nonatomic, strong) NSString *facebookLocale;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSArray *friends;

+ (void)setWithFacebookUser:(id<FBGraphUser>)facebookUser;
+ (DTTempUser *)sharedUser;
+ (void)fetchFriends;

@end
