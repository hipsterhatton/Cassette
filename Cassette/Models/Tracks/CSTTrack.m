//
//  CSTTrack.m
//  Cassette
//
//  Created by Stephen Hatton on 24/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTTrack.h"

@implementation CSTTrack

+ (NSDictionary *)getJSONStructure
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary
                                       :@{
                                          
                                          @"_id"                : @"set/track/id",
                                          @"name"               : @"set/track/name",
                                          @"performer"          : @"set/track/performer",
                                          @"trackURL"           : @"set/track/track_file_stream_url",
                                          @"likedByUser"        : @"set/track/faved_by_current_user",
                                          @"atBeginning"        : @"set/at_beginning",
                                          @"atLastTrack"        : @"set/at_last_track",
                                          @"atEnd"              : @"set/at_end",
                                          @"skipAllowed"        : @"set/skip_allowed"
                                          
                                          }];
    
    return dictionary;
}

+ (NSDictionary *)getAltJSONStructure
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary
                                       :@{
                                          
                                          @"_id"                : @"id",
                                          @"name"               : @"name",
                                          @"performer"          : @"performer",
                                          @"trackURL"           : @"track_file_stream_url",
                                          @"likedByUser"        : @"faved_by_current_user",
                                          
                                          }];
    
    return dictionary;
}

@end
