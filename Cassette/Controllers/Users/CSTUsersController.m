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



- (void)getUserDetails:(NSString *)userID
{
    [self.shuttle launch:GET :JSON :[self.api getUserDetails:userID] :nil]
    
    
    .then(^id (NSDictionary *rawJSON) {
        
        CSTUser *user = [CSTUser createViaJSON:rawJSON :[CSTUser getUserJSONStructure]];
        _user = user;
        
        [self _extractUserFollowers:_user :rawJSON];
        [self _extractUserFollowing:_user :rawJSON];
        [self _extractCollections:_user :rawJSON];
        
        return @"OK";
    }, nil)
    
    
    .then(nil, ^id(NSError* error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        return nil;
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
    }
    
    
}



- (void)getUserMixes:(CSTUser *)user
{
    [self.shuttle launch:GET :JSON :[self.api getUserMixes:[user getID] :1] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        
        if (![user madeMixes]) {
            [user setMadeMixes:[[NSMutableArray alloc] init]];
        }
        
        [[user madeMixes] addObjectsFromArray: [CSTBaseMix createArrayObjectsViaJSON:rawJSON :@"mix_set/mixes" :[CSTBaseMix getJSONStructure] :[CSTBaseMix class]] ];
        
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError* error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        return nil;
    });
}

- (void)getLikedMixes:(CSTUser *)user
{    
    [self.shuttle launch:GET :JSON :[self.api getLikedMixes:[user getID] :1] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        
        if (![user likedMixes]) {
            [user setLikedMixes:[[NSMutableArray alloc] init]];
        }
        
        [[user likedMixes] addObjectsFromArray: [CSTBaseMix createArrayObjectsViaJSON:rawJSON :@"mix_set/mixes" :[CSTBaseMix getJSONStructure] :[CSTBaseMix class]] ];
        
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError* error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        return nil;
    });
}

- (void)getLikedTracks:(CSTUser *)user
{
    [self.shuttle launch:GET :JSON :[self.api getLikedTracks:[user getID] :1] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        NSLog(@"Raw JSON: %@", rawJSON);
        if (![user likedTracks]) {
            [user setLikedTracks:[[NSMutableArray alloc] init]];
        }
        
        [[user likedTracks] addObjectsFromArray: [CSTBaseMix createArrayObjectsViaJSON:rawJSON :@"tracks" :[CSTTrack getAltJSONStructure] :[CSTTrack class]] ];
        
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError* error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        return nil;
    });
}



- (void)getUserFollowers:(CSTUser *)user
{
    [self.shuttle launch:GET :JSON :[self.api getFollowers:@"1" :1] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        
        if (![user followers]) {
            [user setFollowers:[[NSMutableArray alloc] init]];
        }
        
        [[user followers] addObjectsFromArray: [CSTBaseMix createArrayObjectsViaJSON:rawJSON :@"users" :[CSTUser getFollowingOrFollowersUserJSONStructure] :[CSTUser class]] ];
        
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError* error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        return nil;
    });
}

- (void)getUserFollowing:(CSTUser *)user
{
    [self.shuttle launch:GET :JSON :[self.api getFollowing:@"1" :1] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        
        if (![user following]) {
            [user setFollowing:[[NSMutableArray alloc] init]];
        }
        
        [[user following] addObjectsFromArray: [CSTBaseMix createArrayObjectsViaJSON:rawJSON :@"users" :[CSTUser getFollowingOrFollowersUserJSONStructure] :[CSTUser class]] ];
        
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError* error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        return nil;
    });
}

@end
