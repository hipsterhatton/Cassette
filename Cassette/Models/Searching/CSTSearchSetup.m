//
//  CSTSearchSetup.m
//  Cassette
//
//  Created by Stephen Hatton on 24/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTSearchSetup.h"

@implementation CSTSearchSetup

- (instancetype)init
{
    _pageNumber = 1;
    _resultsPerPage = 3;
    _sort = @"hot";
    return self;
}



- (BOOL)nextPage
{
    if ( (_pageNumber * _resultsPerPage) < _numberOfResults ) {
        _pageNumber++;
        return true;
    } else {
        return false;
    }
}

- (BOOL)previousPage
{
    if (_pageNumber >= 2) {
        _pageNumber--;
        return true;
    } else {
        return false;
    }
}


+ (NSDictionary *)getJSONStructure
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary
                                       :@{
                                          
                                          @"pageNumber"         : @"mix_set/pagination/current_page",
                                          @"numberOfResults"    : @"mix_set/pagination/total_entries",
                                          
                                          }];
    
    return dictionary;
}

+ (NSDictionary *)getAltJSONStructure
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary
                                       :@{
                                          
                                          @"pageNumber"         : @"pagination/current_page",
                                          @"numberOfResults"    : @"pagination/total_entries",
                                          
                                          }];
    
    return dictionary;
}

@end
