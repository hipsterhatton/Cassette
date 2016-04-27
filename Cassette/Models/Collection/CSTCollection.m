//
//  CSTCollection.m
//  Cassette
//
//  Created by Stephen Hatton on 26/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTCollection.h"

@implementation CSTCollection

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

@end
