//
//  DTBackendManager.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 19/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTBackendManager.h"

#define BASE_URL @"http://127.0.0.1:8000/"

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

#pragma mark - Services -
#pragma mark Identify user

+ (void)identifyUserWithGraph:(id)userGraph
                      success:(void (^)(NSURLSessionDataTask *, NSDictionary *))success
                      failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    [[DTBackendManager sharedManager] identifyUserWithGraph:userGraph
                                                    success:success
                                                    failure:failure];
}

- (void)identifyUserWithGraph:(id)userGraph
                      success:(void (^)(NSURLSessionDataTask *, NSDictionary *))success
                      failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    [self POST:@"login/" parameters:userGraph success:success failure:failure];
}

#pragma mark Update friend list

+ (void)updateFirendList:(NSArray *)friendList
                 success:(void (^)(NSURLSessionDataTask *, NSDictionary *))success
                 failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    [[DTBackendManager sharedManager] updateFirendList:friendList
                                               success:success
                                               failure:failure];
}

- (void)updateFirendList:(NSArray *)friendList
                 success:(void (^)(NSURLSessionDataTask *, NSDictionary *))success
                 failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    [self GET:@"persons/" parameters:nil success:success failure:failure];
}

@end
