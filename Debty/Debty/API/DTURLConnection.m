//
//  AFIURLConnection.m
//  sFetch
//
//  Created by Tanguy Hélesbeux on 13/11/2013.
//  Copyright (c) 2013 AnyFetch - INSA. All rights reserved.
//

#import "DTURLConnection.h"

@interface DTURLConnection()

@property (strong, nonatomic) NSMutableData *data;

@end;

@implementation DTURLConnection

- (id)initWithRequest:(NSURLRequest *)request delegate:(id)delegate
{
    self = [super initWithRequest:request delegate:self];
    if (self) {
        _connectionDelegate = delegate;
        self.shouldReturnJson = YES;
    }
    return self;
}

+ (DTURLConnection *)connectionWithRequest:(NSURLRequest *)request delegate:(id)delegate
{
    return [[DTURLConnection alloc] initWithRequest:request delegate:delegate];
}

- (void)startConnection
{
    self.data = [[NSMutableData alloc] init];
    [super start];
    if ([self.connectionDelegate respondsToSelector:@selector(connectionDidStart:)])
    {
        [self.connectionDelegate connectionDidStart:self];
    }
}

#pragma mark NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if ([self.connectionDelegate respondsToSelector:@selector(connection:didFailWithError:)]) {
        [self.connectionDelegate connection:self didFailWithError:error];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (!self.shouldReturnJson) {
        if ([self.connectionDelegate respondsToSelector:@selector(connection:didReceiveData:)]) {
            [self.connectionDelegate connection:self didReceiveData:self.data];
        }
    } else {
        if ([self.connectionDelegate respondsToSelector:@selector(connection:didReceiveJson:)]) {
            
            NSError* error;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:self.data options:kNilOptions error:&error];
            
            if (error) {
                [self connection:connection didFailWithError:error];
            } else {
                [self.connectionDelegate connection:connection didReceiveJson:json];
            }
        }
    }
}

@end
