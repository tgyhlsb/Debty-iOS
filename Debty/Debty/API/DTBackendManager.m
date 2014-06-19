//
//  DTBackendManager.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 19/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTBackendManager.h"

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

+ (void)identifyUserWithGraph:(id)userGraph
                      success:(void (^)(AFHTTPRequestOperation *))success
                      failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    [[DTBackendManager sharedManager] identifyUserWithGraph:userGraph
                                                    success:success
                                                    failure:failure];
}

- (void)identifyUserWithGraph:(id)userGraph
                      success:(void (^)(AFHTTPRequestOperation *))success
                      failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    [self GET:@"login/" parameters:userGraph success:^(NSURLSessionDataTask *task, id responseObject) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

@end
