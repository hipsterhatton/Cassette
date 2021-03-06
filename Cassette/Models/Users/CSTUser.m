//
//  CSTUser.m
//  Cassette
//
//  Created by Stephen Hatton on 26/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTUser.h"

@implementation CSTUser

+ (NSDictionary *)getUserJSONStructure
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary
                                       :@{
                                          
                                          @"_id"                : @"user/id",
                                          @"name"               : @"user/login",
                                          @"avatar"             : @"user/avatar_urls/max200"
                                          
                                          }];
    
    return dictionary;
}

+ (NSDictionary *)getLoggedInUserJSONStructure
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary
                                       :@{
                                          
                                          @"_id"                : @"user/id",
                                          @"name"               : @"user/login",
                                          @"avatar"             : @"user/avatar_urls/max200",
                                          @"loggedIn"           : @"logged_in"
                                          
                                          }];
    
    return dictionary;
}


+ (NSDictionary *)getFollowingOrFollowersUserJSONStructure
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary
                                       :@{
                                          
                                          @"_id"                : @"id",
                                          @"name"               : @"login",
                                          @"avatar"             : @"avatar_urls/max200"
                                          
                                          }];
    
    return dictionary;
}

+ (NSDictionary *)getAutocompleteUserJSONStructure
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary
                                       :@{
                                          
                                          @"_id"                : @"id",
                                          @"name"               : @"name",
                                          @"avatar"             : @"data/image_url"
                                          
                                          }];
    
    return dictionary;
}


- (NSString *)getID
{
    return [NSString stringWithFormat:@"%@", __id];
}

@end
