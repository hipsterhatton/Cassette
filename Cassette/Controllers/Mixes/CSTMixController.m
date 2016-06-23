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

- (RXPromise *)getMixDetails:(NSString *)mixID
{ 
    return [self.shuttle launch:GET :JSON :[self.api getMixDetails:mixID] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError *error) {
        [self raiseError:error :x(self) :y];
        return error;
    });
}

- (RXPromise *)getSimilarMixes:(CSTBaseMix *)mix
{
    if ([mix similarMixes]) {
        if ([[mix similarMixes] count] > 0) {
            return nil;
        }
    }
    
    return [self.shuttle launch:GET :JSON :[self.api getSimilarMix:[mix _id]] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        
        if (![mix similarMixes]) {
            [mix setSimilarMixes:[[NSMutableArray alloc] init]];
        }
        
        [[mix similarMixes] addObject: [CSTBaseMix createViaJSON:rawJSON :[CSTBaseMix getSimilarMixJSONStructure]] ];
        
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError *error) {
        [self raiseError:error :x(self) :y];
        return error;
    });
}

- (RXPromise *)getTracksAlreadyPlayed:(CSTBaseMix *)mix
{
    if ([mix tracksPlayed]) {
        if ([[mix tracksPlayed] count] > 0) {
            return nil;
        }
    }
    
    return [self.shuttle launch:GET :JSON :[self.api getListOfTracksPlayed:[mix _id]] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        
        if (![mix tracksPlayed]) {
            [mix setTracksPlayed:[[NSMutableArray alloc] init]];
        }
        
        [[mix tracksPlayed] addObjectsFromArray:[CSTTrack createArrayObjectsViaJSON
                                                 :rawJSON
                                                 :@"tracks"
                                                 :[CSTTrack getAltJSONStructure]
                                                 :[CSTTrack class]]
         ];
        
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError* error) {
        [self raiseError:error :x(self) :y];
        return error;
    });
}

@end
