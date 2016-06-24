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
@property (nonatomic) BOOL gotPlayToken;

+ (id)sharedManager;

- (NSString *)getAPIversion;
- (NSString *)getAPIkey;

- (NSString *)logUserIn;
- (NSString *)logUserOut;
- (NSString *)signUpUser;

- (NSString *)getHomepageMixes:(NSString *)sort :(int)pageNumber :(int)numberPerPage;

- (NSString *)getMixDetails:(NSString *)mixID;
- (NSString *)getSimilarMix:(NSString *)mixID;
- (NSString *)getListOfTracksPlayed:(NSString *)mixID;

- (NSString *)playMix:(NSString *)mixID;
- (NSString *)nextTrackInMix:(NSString *)mixID;

- (NSString *)getTopTags:(int)pageNumber :(int)perPage;
- (NSString *)autocompleteTags:(NSString *)string;
- (NSString *)getTagsAndMixes:(NSString *)tagList :(int)pageNumber :(int)perPage;

- (NSString *)getUserDetails:(NSString *)userID;
- (NSString *)getUserMixes:(NSString *)userID :(int)pageNumber :(int)perPage;

- (NSString *)getLikedMixes:(NSString *)userID :(int)pageNumber :(int)perPage;
- (NSString *)getLikedTracks:(NSString *)userID :(int)pageNumber :(int)perPage;
- (NSString *)getFollowing:(NSString *)userID :(int)pageNumber :(int)perPage;
- (NSString *)getFollowers:(NSString *)userID :(int)pageNumber :(int)perPage;

- (NSString *)getCollections:(NSString *)userID;
- (NSString *)getEditableCollections:(NSString *)userName; // this one called only for Signed In Users? Or do we combine the 2 values into one...

- (NSString *)autoCompleteSearch:(NSString *)searchTerm;

- (NSString *)createCollection;
- (NSString *)addToCollection;
- (NSString *)updateCollection:(NSString *)collectionID;
- (NSString *)deleteCollection:(NSString *)collectionID;

- (NSString *)reportTrack:(NSString *)trackID :(NSString *)mixID;

@end
