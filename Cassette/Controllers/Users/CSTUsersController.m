//
//  CSTUsersController.m
//  Cassette
//
//  Created by Stephen Hatton on 26/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTUsersController.h"

@implementation CSTUsersController

- (instancetype)init
{
    self = [super init];
    return self;
}



- (RXPromise *)getUserDetails:(NSString *)userID
{
    return [self.shuttle launch:GET :JSON :[self.api getUserDetails:userID] :nil]
    
    
    .then(^id (NSDictionary *rawJSON) {
        
        CSTUser *user = [CSTUser createViaJSON:rawJSON :[CSTUser getUserJSONStructure]];
        _user = user;
        
        [self _extractUserFollowers:_user :rawJSON];
        [self _extractUserFollowing:_user :rawJSON];
        [self _extractCollections:_user :rawJSON];
        
        return @"OK";
    }, nil)
    
    
    .then(nil, ^id(NSError *error) {
        [self raiseError:error :x(self) :y];
        return error;
    });
}



- (void)_extractUserFollowers:(CSTUser *)user :(NSDictionary *)rawJSON
{
    if (![user followers]) {
        [user setFollowers:[[NSMutableArray alloc] init]];
    }

    [[user followers] addObjectsFromArray: [CSTUser createArrayObjectsViaJSON
                                            :rawJSON
                                            :@"user/followed_by_users"
                                            :[CSTUser getFollowingOrFollowersUserJSONStructure]
                                            :[CSTUser class] ]
     ];
}

- (void)_extractUserFollowing:(CSTUser *)user :(NSDictionary *)rawJSON
{
    if (![user following]) {
        [user setFollowing:[[NSMutableArray alloc] init]];
    }
    
    [[user following] addObjectsFromArray: [CSTUser createArrayObjectsViaJSON
                                            :rawJSON
                                            :@"user/follows_users"
                                            :[CSTUser getFollowingOrFollowersUserJSONStructure]
                                            :[CSTUser class] ]
     ];
}

- (void)_extractCollections:(CSTUser *)user :(NSDictionary *)rawJSON
{
    if (![user collections]) {
        [user setCollections:[[NSMutableArray alloc] init]];
    }
    
    NSArray *array = [CSTUser createArrayViaJSON:rawJSON :@"user/collections"];

    for (NSDictionary *object in array) {
        
        CSTCollection *collection = [CSTCollection createViaJSON:object :@{}];
        
        [collection setMixes:[[NSMutableArray alloc] init]];
        
        NSArray *mixes = [CSTBaseMix createArrayObjectsViaJSON
                           :object
                           :@"mixes"
                           :[CSTBaseMix getJSONStructure]
                           :[CSTBaseMix class]
                          ];

        [[collection mixes] addObjectsFromArray: mixes ];
        
        [[_user collections] addObject:collection];
    }
}



- (RXPromise *)getUserMixes:(CSTUser *)user
{
    if (![user madeMixesSearchSetup]) {
        [user setMadeMixesSearchSetup:[[CSTSearchSetup alloc] init]];
    }
    
    return [self.shuttle launch:GET :JSON :[self.api getUserMixes
                                     :[user getID]
                                     :[[user madeMixesSearchSetup] pageNumber]
                                     :[[user madeMixesSearchSetup] resultsPerPage]
                                     ] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        
        if (![user madeMixes]) {
            [user setMadeMixes:[[NSMutableArray alloc] init]];
        }
        
        [[user madeMixes] addObjectsFromArray:
         [CSTBaseMix createArrayObjectsViaJSON:rawJSON :@"mix_set/mixes" :[CSTBaseMix getJSONStructure] :[CSTBaseMix class]]
        ];
        
        [[user madeMixesSearchSetup] updateViaJSON:rawJSON :[CSTSearchSetup getJSONStructure]];
    
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError *error) {
        [self raiseError:error :x(self) :y];
        return error;
    });
}

- (RXPromise *)getLikedMixes:(CSTUser *)user
{
    if (![user likedMixesSearchSetup]) {
        [user setLikedMixesSearchSetup:[[CSTSearchSetup alloc] init]];
    }
    
    return [self.shuttle launch:GET :JSON :[self.api getLikedMixes
                                     :[user getID]
                                     :[[user likedMixesSearchSetup] pageNumber]
                                     :[[user likedMixesSearchSetup] resultsPerPage]
                                     ] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        
        if (![user likedMixes]) {
            [user setLikedMixes:[[NSMutableArray alloc] init]];
        }
        
        [[user likedMixes] addObjectsFromArray:
         [CSTBaseMix createArrayObjectsViaJSON:rawJSON :@"mix_set/mixes" :[CSTBaseMix getJSONStructure] :[CSTBaseMix class]]
        ];
        
        [[user likedMixesSearchSetup] updateViaJSON:rawJSON :[CSTSearchSetup getJSONStructure]];

        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError *error) {
        [self raiseError:error :x(self) :y];
        return error;
    });
}

- (RXPromise *)getLikedTracks:(CSTUser *)user
{
    if (![user likedTracksSearchSetup]) {
        [user setLikedTracksSearchSetup:[[CSTSearchSetup alloc] init]];
    }
    
    return [self.shuttle launch:GET :JSON :[self.api getLikedTracks
                                     :[user getID]
                                     :[[user likedTracksSearchSetup] pageNumber]
                                     :[[user likedTracksSearchSetup] resultsPerPage]
                                     ] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        if (![user likedTracks]) {
            [user setLikedTracks:[[NSMutableArray alloc] init]];
        }
        
        [[user likedTracks] addObjectsFromArray:
         [CSTBaseMix createArrayObjectsViaJSON:rawJSON :@"tracks" :[CSTTrack getAltJSONStructure] :[CSTTrack class]]
        ];
        
        [[user likedTracksSearchSetup] updateViaJSON:rawJSON :[CSTSearchSetup getAltJSONStructure]];
        
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError *error) {
        [self raiseError:error :x(self) :y];
        return error;
    });
}



- (RXPromise *)getUserFollowers:(CSTUser *)user
{
    if (![user followersSearchSetup]) {
        [user setFollowersSearchSetup:[[CSTSearchSetup alloc] init]];
    }
    
    return [self.shuttle launch:GET :JSON :[self.api getFollowers
                                     :[user getID]
                                     :[[user followersSearchSetup] pageNumber]
                                     :[[user followersSearchSetup] resultsPerPage]
                                     ] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        
        if (![user followers]) {
            [user setFollowers:[[NSMutableArray alloc] init]];
        }
        
        [[user followers] addObjectsFromArray:
         [CSTBaseMix createArrayObjectsViaJSON:rawJSON :@"users" :[CSTUser getFollowingOrFollowersUserJSONStructure] :[CSTUser class]]
        ];
        
        [[user followersSearchSetup] updateViaJSON:rawJSON :[CSTSearchSetup getAltJSONStructure]];
        
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError *error) {
        [self raiseError:error :x(self) :y];
        return error;
    });
}

- (RXPromise *)getUserFollowing:(CSTUser *)user
{
    if (![user following]) {
        [user setFollowingSearchSetup:[[CSTSearchSetup alloc] init]];
    }
    
    return [self.shuttle launch:GET :JSON :[self.api getFollowing
                                     :[user getID]
                                     :[[user followingSearchSetup] pageNumber]
                                     :[[user followingSearchSetup] resultsPerPage]
                                     ] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        
        if (![user following]) {
            [user setFollowing:[[NSMutableArray alloc] init]];
        }
        
        [[user following] addObjectsFromArray:
         [CSTBaseMix createArrayObjectsViaJSON:rawJSON :@"users" :[CSTUser getFollowingOrFollowersUserJSONStructure] :[CSTUser class]]
        ];
        
        [[user followingSearchSetup] updateViaJSON:rawJSON :[CSTSearchSetup getAltJSONStructure]];
        
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError *error) {
        [self raiseError:error :x(self) :y];
        return error;
    });
}

@end
