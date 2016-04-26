//
//  EightTracksAPI.h
//  Cassette
//
//  Created by Stephen Hatton on 24/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EightTracksAPI : NSObject

@property (nonatomic, retain) NSString *playToken;

+ (id)sharedManager;

- (NSString *)getAPIversion;
- (NSString *)getAPIkey;

- (NSString *)getHomepageMixes:(NSString *)sort :(int)pageNumber :(int)numberPerPage;

- (NSString *)getMixDetails:(NSString *)mixID;
- (NSString *)getSimilarMix:(NSString *)mixID;
- (NSString *)getListOfTracksPlayed:(NSString *)mixID;

- (NSString *)playMix:(NSString *)mixID;
- (NSString *)nextTrackInMix:(NSString *)mixID;

- (NSString *)getTopTags:(int)pageNumber;
- (NSString *)autocompleteTags:(NSString *)string;
- (NSString *)getTagsAndMixes:(NSString *)tagList :(int)pageNumber;

- (NSString *)reportTrack:(NSString *)trackID :(NSString *)mixID;

@end
