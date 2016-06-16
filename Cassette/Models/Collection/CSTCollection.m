//
//  CSTCollection.m
//  Cassette
//
//  Created by Stephen Hatton on 26/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTCollection.h"

@implementation CSTCollection

- (BOOL)isListenLater
{
    if ([_name containsString:@"Listen later"]) {
        if ([_smart_id containsString:@":listen-later"]) {
            return true;
        }
    }
    
    return false;
}

+ (NSDictionary *)getJSONStructure
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary
                                       :@{
                                          
                                          @"_id"        : @"id",
                                          @"name"       : @"name",
                                          @"_description": @"description",
                                          @"smart_id"   : @"smart_id"
                                          
                                          }];
    
    return dictionary;
}

+ (NSDictionary *)getJSONStructureWithPaths
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary
                                       :@{
                                          
                                          @"_id"        : @"collection/id",
                                          @"name"       : @"collection/name",
                                          @"_description": @"collection/description",
                                          @"smart_id"   : @"collection/smart_id"
                                          
                                          }];
    
    return dictionary;
}

@end
