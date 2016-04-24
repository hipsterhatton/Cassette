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



- (NSString *)getHomepageMixes
{
    return @"http://8tracks.com/mix_sets/all.json?include=mixes+pagination&page=1&per_page=12";
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