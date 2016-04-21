//
//  Shuttle.h
//  Cassette
//
//  Created by Stephen Hatton on 21/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <Foundation/Foundation.h>
#import <RXPromise/RXPromise.h>

@interface Shuttle : NSObject

typedef enum {
    GET,
    POST
} ShuttleModes;

typedef enum {
    HTTP,
    JSON
} ShuttleResponses;



@property (nonatomic, retain) AFHTTPSessionManager *manager;

@property (nonatomic, retain) AFHTTPResponseSerializer *HTTPResponse;
@property (nonatomic, retain) AFJSONResponseSerializer *JSONResponse;



- (instancetype)initWithDefaults:(NSDictionary *)defaults;
- (void)updateDefaults:(NSDictionary *)defaults;

- (RXPromise *)launch:(ShuttleModes)mode :(ShuttleResponses)response :(NSString *)url :(NSDictionary *)params;

@end
