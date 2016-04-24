//
//  CSTFullMix.m
//  Cassette
//
//  Created by Stephen Hatton on 24/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTFullMix.h"

@implementation CSTFullMix

+ (NSDictionary *)getJSONStructureWithPaths
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary
                                       :@{
                                          
                                          @"playsCount"         : @"mix/plays_count",
                                          @"likesCount"         : @"mix/likes_count",
                                          @"tracksCount"        : @"mix/tracks_count"
                                          
                                          }];
    
    return dictionary;
}

@end
