//
//  AFIURLConnection.h
//  sFetch
//
//  Created by Tanguy Hélesbeux on 13/11/2013.
//  Copyright (c) 2013 AnyFetch - INSA. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DTURLConnectionDelegate;

@interface DTURLConnection : NSURLConnection <NSURLConnectionDataDelegate>

@property (weak, nonatomic) id <DTURLConnectionDelegate> connectionDelegate;

@property (strong, nonatomic) void(^completionBlock)(id data, NSError *error);

@property (nonatomic) BOOL shouldReturnJson;

- (id)initWithRequest:(NSURLRequest *)request
             delegate:(id)delegate;

+ (DTURLConnection *)connectionWithRequest:(NSURLRequest *)request
                                   delegate:(id)delegate;


- (void)startConnection;

@end

@protocol DTURLConnectionDelegate <NSObject>

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;

@optional

- (void)connectionDidStart:(DTURLConnection *)connection;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connection:(NSURLConnection *)connection didReceiveJson:(NSDictionary *)json;

@end

