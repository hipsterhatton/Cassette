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
    return self;
}

- (void)getHomepageMixes
{
    [self.shuttle launch:GET :JSON :[self.api getHomepageMixes] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        
        if (!_homepageMixes) {
            _homepageMixes = [[NSMutableArray alloc] init];
        }
        
        [_homepageMixes addObjectsFromArray:
         [CSTBaseMix createArrayObjectsViaJSON:rawJSON :@"mix_set/mixes" :[CSTBaseMix getJSONStructure] :[CSTBaseMix class]]
         ];
        
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError* error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        return nil;
    });
}

// this needs updating to use some sort of search setup object :: that allows for pagination, etc.

@end
