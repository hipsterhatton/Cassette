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
                                          
                                          }];
    
    return dictionary;
}

@end
