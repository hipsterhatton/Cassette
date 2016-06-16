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
    _mixesSearchSetup = [[CSTSearchSetup alloc] init];
    return self;
}

- (void)getHomepageMixes
{
    [self.shuttle launch:GET :JSON :[self.api getHomepageMixes:[_mixesSearchSetup sort]
                                                              :[_mixesSearchSetup pageNumber]
                                                              :[_mixesSearchSetup resultsPerPage]
                                     ] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        
        if (!_homepageMixes) {
            _homepageMixes = [[NSMutableArray alloc] init];
        }
        
        [_homepageMixes addObjectsFromArray:
         [CSTBaseMix createArrayObjectsViaJSON:rawJSON :@"mix_set/mixes" :[CSTBaseMix getJSONStructure] :[CSTBaseMix class]]
         ];
        
        [_mixesSearchSetup updateViaJSON:rawJSON :[CSTSearchSetup getJSONStructure]];
        
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError* error) {
        [self raiseError:error :x(self) :y];
        return nil;
    });
}

- (void)getHomepageMixesNextPage
{
    if ([_mixesSearchSetup nextPage]) {
        [self getHomepageMixes];
    }
}

@end
