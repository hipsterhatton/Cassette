//
//  CSTMixExplorerController.m
//  Cassette
//
//  Created by Stephen Hatton on 24/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTMixExplorerController.h"
#import "CSTBaseMix.h"

@implementation CSTMixExplorerController

- (instancetype)init
{
    self = [super init];
    _searchSetup = [[CSTSearchSetup alloc] init];
    return self;
}

- (void)getHomepageMixes
{
    [self.shuttle launch:GET :JSON :[self.api getHomepageMixes:[_searchSetup sort]
                                                              :[_searchSetup pageNumber]
                                                              :[_searchSetup resultsPerPage]
                                     ] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        
        if (!_homepageMixes) {
            _homepageMixes = [[NSMutableArray alloc] init];
        }
        
        [_homepageMixes addObjectsFromArray:
         [CSTBaseMix createArrayObjectsViaJSON:rawJSON :@"mix_set/mixes" :[CSTBaseMix getJSONStructure] :[CSTBaseMix class]]
         ];
        
        [_searchSetup updateViaJSON:rawJSON :[CSTSearchSetup getJSONStructure]];
        
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError* error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        return nil;
    });
}

- (void)homepageMixesNextPage
{
    if ([_searchSetup nextPage]) {
        [self getHomepageMixes];
    }
}

@end
