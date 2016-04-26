//
//  CSTTag.m
//  Cassette
//
//  Created by Stephen Hatton on 25/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTTag.h"

@implementation CSTTag

+ (NSDictionary *)getJSONStructure
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary
                                       :@{
                                          
                                          @"name"                : @"name"
                                          
                                          }];
    
    return dictionary;
}

@end
