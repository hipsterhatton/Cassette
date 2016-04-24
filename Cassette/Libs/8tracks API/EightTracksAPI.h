//
//  EightTracksAPI.h
//  Cassette
//
//  Created by Stephen Hatton on 24/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EightTracksAPI : NSObject

+ (id)sharedManager;

- (NSString *)getAPIversion;
- (NSString *)getAPIkey;

- (NSString *)getHomepageMixes;
- (NSString *)getMixDetails:(NSString *)mixID;
- (NSString *)getSimilarMix:(NSString *)playToken :(NSString *)mixID;
- (NSString *)getListOfTracksPlayed:(NSString *)playToken :(NSString *)mixID;

@end
