//
//  CSTMixController.m
//  Cassette
//
//  Created by Stephen Hatton on 24/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTMixController.h"

@implementation CSTMixController

- (instancetype)init
{
    self = [super init];
    return self;
}

- (void)getMixDetails:(NSString *)mixID
{
    [self.shuttle launch:GET :JSON :[self.api getMixDetails:mixID] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        NSLog(@"Raw JSON: %@", rawJSON);
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError* error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        return nil;
    });
}

- (void)getSimilarMixes:(NSString *)mixID
{
    [self.shuttle launch:GET :JSON :[self.api getSimilarMix:mixID] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        NSLog(@"Raw JSON: %@", rawJSON);
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError* error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        return nil;
    });
}

- (void)setTracksAlreadyPlayed:(NSString *)mixID
{
    [self.shuttle launch:GET :JSON :[self.api getListOfTracksPlayed:mixID] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        NSLog(@"Raw JSON: %@", rawJSON);
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError* error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        return nil;
    });
}

@end
