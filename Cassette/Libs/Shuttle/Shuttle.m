//
//  Shuttle.m
//  Cassette
//
//  Created by Stephen Hatton on 21/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "Shuttle.h"

@implementation Shuttle

+ (id)sharedManagerWithDefaults:(NSDictionary *)defaults
{
    static Shuttle *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] initWithDefaults:defaults];
    });
    
    return sharedMyManager;
}

+ (id)sharedManager
{
    return self;
}

- (instancetype)initWithDefaults:(NSDictionary *)defaults
{
    self = [[Shuttle alloc] init];
    _manager = [AFHTTPSessionManager new];
    
    for (NSString *key in defaults) {
        [[_manager requestSerializer] setValue:defaults[key] forHTTPHeaderField:key];
    }
    
    _HTTPResponse = [AFHTTPResponseSerializer new];
    _JSONResponse = [AFJSONResponseSerializer new];
    
    [_manager setResponseSerializer:_HTTPResponse];
    
    return self;
}

- (void)updateDefaults:(NSDictionary *)defaults
{
    for (NSString *key in defaults) {
        [[_manager requestSerializer] setValue:defaults[key] forKey:key];
    }
}



- (RXPromise *)launch:(ShuttleModes)mode :(ShuttleResponses)response :(NSString *)url :(NSDictionary *)params
{
    RXPromise *promise = [RXPromise new];
    
    NSLog(@"\n\n\nURL: %@\n\n\n", url);
    
    if (response == JSON) {
        [_manager setResponseSerializer:_JSONResponse];
    } else {
        [_manager setResponseSerializer:_HTTPResponse];
    }
    
    
    if (mode == GET) {
        
        [_manager GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            [self url_success:promise :responseObject :url];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            [self url_failure:promise :error :url];
        }];
        
    } else if (mode == POST) {
        
        [_manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            [self url_success:promise :responseObject :url];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            [self url_failure:promise :error :url];
        }];
        
    } else if (mode == PUT) {
        
        [_manager PUT:url parameters:params success:^(NSURLSessionTask *task, id responseObject) {
            [self url_success:promise :responseObject :url];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            [self url_failure:promise :error :url];
        }];
        
    } else {
        
        [_manager DELETE:url parameters:params success:^(NSURLSessionTask *task, id responseObject) {
            [self url_success:promise :responseObject :url];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            [self url_failure:promise :error :url];
        }];
        
    }
    
    
    return promise;
}

- (void)url_success:(RXPromise *)promise :(NSObject *)data :(NSString *)url
{
    [promise fulfillWithValue:data];
}

- (void)url_failure:(RXPromise *)promise :(NSError *)error :(NSString *)url
{
    [promise rejectWithReason:error];
}

@end
