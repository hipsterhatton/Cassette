//
//  EightTracksAPI.m
//  Cassette
//
//  Created by Stephen Hatton on 24/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "EightTracksAPI.h"

#define API_KEY @"adc8784bb142978f2abf78cbefa1e6f34d3c9bbe";
#define API_VER @"3";

#define i_to_s(i)   [NSString stringWithFormat:@"%d", i]
#define stringify(s)[NSString stringWithFormat:@"%@", s]

@implementation EightTracksAPI

+ (id)sharedManager
{
    static EightTracksAPI *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        [sharedMyManager setPlayToken:@"http://8tracks.com/sets/new.json"];
    });
    
    return sharedMyManager;
}



- (NSString *)getAPIversion
{
    return API_VER;
}

- (NSString *)getAPIkey
{
    return API_KEY;
}




- (NSString *)getHomepageMixes:(NSString *)sort :(int)pageNumber :(int)numberPerPage
{
    NSString *url = @"http://8tracks.com/mix_sets/all:#{Sort}.json?include=mixes+pagination&page=#{PageNumber}&per_page=#{PerPage}";
    NSArray *placeholders = @[ @"#{Sort}", @"#{PageNumber}", @"#{PerPage}" ];
    NSArray *values =       @[ sort, i_to_s(pageNumber), i_to_s(numberPerPage) ];
    return [self _replace:url :placeholders :values];
}

- (NSString *)getMixDetails:(NSString *)mixID
{
    NSString *url =         @"http://8tracks.com/mixes/#{MixID}.json";
    NSArray *placeholders = @[ @"#{MixID}" ];
    NSArray *values =       @[ mixID ];
    return [self _replace:url :placeholders :values];
}

- (NSString *)getSimilarMix:(NSString *)mixID
{
    
    NSString *url =         @"http://8tracks.com/sets/#{PlayToken}/next_mix.json?mix_id=#{MixID}";
    NSArray *placeholders = @[ @"#{PlayToken}", @"#{MixID}" ];
    NSArray *values =       @[ stringify(_playToken), stringify(mixID) ];
    return [self _replace:url :placeholders :values];
}

- (NSString *)getListOfTracksPlayed:(NSString *)mixID
{
    
    NSString *url =         @"http://8tracks.com/sets/#{PlayToken}/tracks_played.json?mix_id=#{MixID}";
    NSArray *placeholders = @[ @"#{PlayToken}", @"#{MixID}" ];
    NSArray *values =       @[ stringify(_playToken), stringify(mixID) ];
    return [self _replace:url :placeholders :values];
}




- (NSString *)playMix:(NSString *)mixID
{
    NSString *url =         @"http://8tracks.com/sets/#{PlayToken}/play.json?mix_id=#{MixID}";
    
    NSArray *placeholders = @[ @"#{PlayToken}", @"#{MixID}" ];
    NSArray *values =       @[ stringify(_playToken), stringify(mixID) ];
    return [self _replace:url :placeholders :values];
}

- (NSString *)nextTrackInMix:(NSString *)mixID
{
    NSString *url =         @"http://8tracks.com/sets/#{PlayToken}/next.json?mix_id=#{MixID}";
    NSArray *placeholders = @[ @"#{PlayToken}", @"#{MixID}" ];
    NSArray *values =       @[ stringify(_playToken), stringify(mixID) ];
    return [self _replace:url :placeholders :values];
}

- (NSString *)reportTrack:(NSString *)trackID :(NSString *)mixID
{
    NSString *url =         @"http://8tracks.com/sets/#{PlayToken}/report.json?track_id=#{TrackID}&mix_id=#{MixID}";
    NSArray *placeholders = @[ @"#{PlayToken}", @"#{TrackID}", @"#{MixID}" ];
    NSArray *values =       @[ stringify(_playToken), stringify(trackID), stringify(mixID) ];
    return [self _replace:url :placeholders :values];
}




- (NSString *)getTopTags:(int)pageNumber
{
    NSString *url =         @"http://8tracks.com/tags.json?include=pagination&page=#{PageNumber}";
    NSArray *placeholders = @[ @"#{PageNumber}" ];
    NSArray *values =       @[ i_to_s(pageNumber) ];
    return [self _replace:url :placeholders :values];
}

- (NSString *)autocompleteTags:(NSString *)string
{
    NSString *url =         @"http://8tracks.com/tags.json?q=#{Tag}";
    NSArray *placeholders = @[ @"#{Tag}" ];
    NSArray *values =       @[ string ];
    return [self _replace:url :placeholders :values];
}

- (NSString *)getTagsAndMixes:(NSString *)tagList :(int)pageNumber
{
    NSString *url =         @"http://8tracks.com/explore/#{TagList}.json?include=details,mixes,pagination,explore_filters&page=#{PageNumber}&format=jsonh";
    NSArray *placeholders = @[ @"#{TagList}", @"#{PageNumber}" ];
    NSArray *values =       @[ tagList, i_to_s(pageNumber) ];
    return [self _replace:url :placeholders :values];
}



- (NSString *)getUserDetails:(NSString *)userID
{
    NSString *url =         @"http://8tracks.com/users/#{UserID}.json?include=collections[mixes]+follows_users+followed_by_users";
    NSArray *placeholders = @[ @"#{UserID}" ];
    NSArray *values =       @[ userID ];
    return [self _replace:url :placeholders :values];
}

- (NSString *)getUserMixes:(NSString *)userID :(int)pageNumber
{
    NSString *url =         @"http://8tracks.com/users/#{UserID}/mixes.json?include=pagination&page=#{PageNumber}";
    NSArray *placeholders = @[ @"#{UserID}", @"#{PageNumber}" ];
    NSArray *values =       @[ userID, i_to_s(pageNumber) ];
    return [self _replace:url :placeholders :values];
}

- (NSString *)getLikedMixes:(NSString *)userID :(int)pageNumber
{
    NSString *url =         @"http://8tracks.com/mix_sets/liked:#{UserID}.json?include=mixes+details+pagination&page=#{PageNumber}";
    NSArray *placeholders = @[ @"#{UserID}", @"#{PageNumber}" ];
    NSArray *values =       @[ userID, i_to_s(pageNumber) ];
    return [self _replace:url :placeholders :values];
}

- (NSString *)getLikedTracks:(NSString *)userID :(int)pageNumber
{
    NSString *url =         @"http://8tracks.com/users/#{UserID}/favorite_tracks.json?include=mixes+details+pagination&page=#{PageNumber}";
    NSArray *placeholders = @[ @"#{UserID}", @"#{PageNumber}" ];
    NSArray *values =       @[ userID, i_to_s(pageNumber) ];
    return [self _replace:url :placeholders :values];
}

- (NSString *)getFollowing:(NSString *)userID :(int)pageNumber
{
    NSString *url =         @"http://8tracks.com/users/#{UserID}/follows_users.json?include=mixes+details+pagination&page=#{PageNumber}";
    NSArray *placeholders = @[ @"#{UserID}", @"#{PageNumber}" ];
    NSArray *values =       @[ userID, i_to_s(pageNumber) ];
    return [self _replace:url :placeholders :values];
}

- (NSString *)getFollowers:(NSString *)userID :(int)pageNumber
{
    NSString *url =         @"http://8tracks.com/users/#{UserID}/followed_by_users.json?include=mixes+details+pagination&page=#{PageNumber}";
    NSArray *placeholders = @[ @"#{UserID}", @"#{PageNumber}" ];
    NSArray *values =       @[ userID, i_to_s(pageNumber) ];
    return [self _replace:url :placeholders :values];
}



- (NSString *)getCollections:(NSString *)userID
{
    NSString *url =         @"http://8tracks.com/users/#{UserID}.json?include=collections[mixes]";
    NSArray *placeholders = @[ @"#{UserID}" ];
    NSArray *values =       @[ userID ];
    return [self _replace:url :placeholders :values];
}

- (NSString *)getEditableCollections:(NSString *)userName
{
    NSString *url =         @"http://8tracks.com/users/#{UserName}/editable_collections.jsonh";
    NSArray *placeholders = @[ @"#{UserName}" ];
    NSArray *values =       @[ userName ];
    return [self _replace:url :placeholders :values];
}



- (NSString *)_replace:(NSString *)string :(NSArray *)placeholders :(NSArray *)values
{
    if ([placeholders count] != [values count]) {
        NSLog(@" ---[Wrong amount of Placeholders and Values] - API");
        return nil;
    }
    
    for (int a = 0; a < [values count]; a++) {
        string = [string stringByReplacingOccurrencesOfString:placeholders[a] withString:values[a]];
    }
    
    return string;
}

@end
