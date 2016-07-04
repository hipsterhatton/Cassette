//
//  CSTAppUser.m
//  Cassette
//
//  Created by Stephen Hatton on 24/06/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTAppUser.h"

@implementation CSTAppUser

- (BOOL)isUserLoggedIn
{
    return _loggedIn;
}

- (void)clearData
{
    _loggedIn = false;
}



- (void)addLikedMix:(NSDictionary *)rawJSON
{
    [[self likedMixes] addObject:[CSTBaseMix createViaJSON:rawJSON :[CSTBaseMix getJSONStructure]]];
}

- (void)removeLikedMix:(NSDictionary *)rawJSON
{
    NSString *mix_id = [NSString stringWithFormat:@"%@", [[rawJSON objectForKey:@"mix"] objectForKey:@"id"]];
    
    int mixFound = -1;
    for (int a = 0; a < [[self likedMixes] count]; a++) {
        if ([[[[self likedMixes] objectAtIndex:a] getID] isEqualToString:mix_id]) {
            mixFound = a;
            return;
        }
    }
    
    if (mixFound != -1) {
        [[self likedMixes] removeObjectAtIndex:mixFound];
    }
}



- (void)addLikedTrack:(NSDictionary *)rawJSON
{
    [[self likedTracks] addObject:[CSTTrack createViaJSON:rawJSON :[CSTTrack getJSONStructure]]];
}

- (void)removeLikedTrack:(NSDictionary *)rawJSON
{
    NSString *mix_id = [NSString stringWithFormat:@"%@", [[rawJSON objectForKey:@"track"] objectForKey:@"id"]];
    
    int trackFound = -1;
    for (int a = 0; a < [[self likedTracks] count]; a++) {
        if ([[[[self likedTracks] objectAtIndex:a] getID] isEqualToString:mix_id]) {
            trackFound = a;
            return;
        }
    }
    
    if (trackFound != -1) {
        [[self likedTracks] removeObjectAtIndex:trackFound];
    }
}



- (void)addFollowedUser:(NSDictionary *)rawJSON
{
    [[self following] addObject:[CSTTrack createViaJSON:rawJSON :[CSTTrack getJSONStructure]]];
}

- (void)removeFollowedUser:(NSDictionary *)rawJSON
{
    NSString *mix_id = [NSString stringWithFormat:@"%@", [[rawJSON objectForKey:@"user"] objectForKey:@"id"]];
    
    int userFound = -1;
    for (int a = 0; a < [[self following] count]; a++) {
        if ([[[[self following] objectAtIndex:a] getID] isEqualToString:mix_id]) {
            userFound = a;
            return;
        }
    }
    
    if (userFound != -1) {
        [[self following] removeObjectAtIndex:userFound];
    }
}

@end
