//
//  CSTBaseMix.m
//  Cassette
//
//  Created by Stephen Hatton on 24/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTBaseMix.h"

@implementation CSTBaseMix

+ (NSDictionary *)getJSONStructure
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary
                                       :@{
                                          
                                          @"_id"                : @"id",
                                          @"name"               : @"name",
                                          @"tagList"            : @"tag_list_cache",
                                          @"certification"      : @"certification",
                                          @"coverImageURL"      : @"cover_urls/sq500",
                                          @"duration"           : @"duration",
                                          @"artistsInMix"       : @"artist_list"
                                          
                                          }];
    
    return dictionary;
}

+ (NSDictionary *)getSimilarMixJSONStructure
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary
                                       :@{
                                          
                                          @"_id"                : @"next_mix/id",
                                          @"name"               : @"next_mix/name",
                                          @"tagList"            : @"next_mix/tag_list_cache",
                                          @"certification"      : @"next_mix/certification",
                                          @"coverImageURL"      : @"next_mix/cover_urls/sq500",
                                          @"duration"           : @"next_mix/duration",
                                          @"artistsInMix"       : @"next_mix/artist_list"
                                          
                                          }];
    
    return dictionary;
}

@end
