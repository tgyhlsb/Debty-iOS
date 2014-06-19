//
//  DTBackendManager.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 19/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "AFNetworking.h"
#import <FacebookSDK/FacebookSDK.h>

@interface DTBackendManager : AFHTTPSessionManager

+ (DTBackendManager *)sharedManager;

+ (void)identifyUserWithGraph:(id<FBGraphUser>)userGraph
                      success:(void (^)(AFHTTPRequestOperation *operation))success
                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
