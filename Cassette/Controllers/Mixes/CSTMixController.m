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
    
    .then(nil, ^id(NSError *error) {
        [self raiseError:error :x(self) :y];
        return nil;
    });
}

- (void)getSimilarMixes:(CSTBaseMix *)mix
{
    if ([mix similarMixes]) {
        if ([[mix similarMixes] count] > 0) {
            return;
        }
    }
    
    [self.shuttle launch:GET :JSON :[self.api getSimilarMix:[mix _id]] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        
        if (![mix similarMixes]) {
            [mix setSimilarMixes:[[NSMutableArray alloc] init]];
        }
        
        [[mix similarMixes] addObject: [CSTBaseMix createViaJSON:rawJSON :[CSTBaseMix getSimilarMixJSONStructure]] ];
        
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError *error) {
        [self raiseError:error :x(self) :y];
        return nil;
    });
}

- (void)getTracksAlreadyPlayed:(CSTBaseMix *)mix
{
    if ([mix tracksPlayed]) {
        if ([[mix tracksPlayed] count] > 0) {
            return;
        }
    }
    
    [self.shuttle launch:GET :JSON :[self.api getListOfTracksPlayed:[mix _id]] :nil]
    
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
        return nil;
    });
}

@end
