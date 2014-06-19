//
//  DTBackendManager.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 19/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>

@interface DTBackendManager : AFHTTPSessionManager

+ (DTBackendManager *)sharedManager;

+ (void)identifyUserWithGraph:(id<FBGraphUser>)userGraph
                      success:(void (^)(NSURLSessionDataTask *task, NSDictionary *json))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (void)updateFirendList:(NSArray *)friendList
                      success:(void (^)(NSURLSessionDataTask *task, NSDictionary *json))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
