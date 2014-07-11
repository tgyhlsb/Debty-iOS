//
//  DTBackendManager.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 19/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTBackendManager.h"
#import "DTFacebookManager.h"
#import "DTInstallation.h"


#define BASE_URL @"http://debty.herokuapp.com/"

static DTBackendManager *sharedManager;

@interface DTBackendManager()


@end

@implementation DTBackendManager

+ (DTBackendManager *)sharedManager
{
    if (!sharedManager) {
        sharedManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    }
    return sharedManager;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    return self;
}

- (void)updateAuthorizationHeader
{
    NSString *identifier = [DTInstallation authIdentifier];
    NSString *password = [DTInstallation authPassword];
    
    [self.requestSerializer setAuthorizationHeaderFieldWithUsername:identifier password:password];
}

#pragma mark - Services -
#pragma mark Identify user

+ (void)identifyUserWithGraph:(id<FBGraphUser>)userGraph
                      success:(void (^)(NSURLSessionDataTask *, NSDictionary *))success
                      failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    [[DTBackendManager sharedManager] identifyUserWithGraph:userGraph
                                                    success:success
                                                    failure:failure];
}

- (void)identifyUserWithGraph:(id<FBGraphUser>)userGraph
                      success:(void (^)(NSURLSessionDataTask *, NSDictionary *))success
                      failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    [self POST:@"login/" parameters:userGraph
       success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
           NSDictionary *user = [[responseObject objectForKey:@"person"] lastObject];
//           TODO is the user new ? or just connected ?
//           NSString *userStatus = [responseObject objectForKey:@"status"];
           [DTInstallation setMeWithInfo:user];
           [self updateUserSuccess:success failure:failure];
    } failure:failure];
}


#pragma mark Update friend list

+ (void)updateUserSuccess:(void (^)(NSURLSessionDataTask *, NSDictionary *))success
                  failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    [[DTBackendManager sharedManager] updateUserSuccess:success
                                                failure:failure];
}

- (void)updateUserSuccess:(void (^)(NSURLSessionDataTask *, NSDictionary *))success
                  failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    [DTFacebookManager fetchFriendsWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (error) {
            NSLog(@"[DTFacebookManager fetchFriendsWithCompletionHandler:]\n%@", error);
            failure(nil, error);
        } else {
            NSArray *friendList = (NSArray *)[result objectForKey:@"data"];
            NSLog(@"[DTBackendManager updateUserSuccess:failure:]\nFound %ld facebook friend(s)", [friendList count]);
            NSArray *friendsIDs = [DTFacebookManager facebookIDForUserArray:friendList];
            NSDictionary *params = @{@"friends": friendsIDs};
            [self updateAuthorizationHeader];
            [self POST:@"updatefriends/" parameters:params success:success failure:failure];
        }
    }];
}


+ (void)getAllPersons:(NSArray *)friendList
                 success:(void (^)(NSURLSessionDataTask *, NSDictionary *))success
                 failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    [[DTBackendManager sharedManager] getAllPersons:friendList
                                               success:success
                                               failure:failure];
}

- (void)getAllPersons:(NSArray *)friendList
                 success:(void (^)(NSURLSessionDataTask *, NSDictionary *))success
                 failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    [self GET:@"persons/" parameters:nil success:success failure:failure];
}

@end
