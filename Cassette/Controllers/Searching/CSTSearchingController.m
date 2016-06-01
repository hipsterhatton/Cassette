//
//  CSTSearchingController.m
//  Cassette
//
//  Created by Stephen Hatton on 01/06/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTSearchingController.h"

@implementation CSTSearchingController

- (instancetype)init
{
    self = [super init];
    _searchSetup = [[CSTSearchSetup alloc] init];
    return self;
}


- (void)searchViaSmartID
{
    // need to convert them...then what? how am I going to keep track of certain things also...
    
    
}

- (void)autocompleteSearch:(NSString *)searchTerm
{
    [self.shuttle launch:GET :JSON :[self.api autoCompleteSearch:searchTerm] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        
        if (!_mixes) {
            _mixes = [[NSMutableArray alloc] init];
        } else {
            [_mixes removeAllObjects];
        }
        
        
        [_mixes addObjectsFromArray:
         [CSTBaseMix createArrayObjectsViaJSON:rawJSON :@"mixes" :[CSTBaseMix getJSONStructure] :[CSTBaseMix class]]
         ];
        
        
        if (!_users) {
            _users = [[NSMutableArray alloc] init];
        } else {
            [_users removeAllObjects];
        }
        
        
        [_users addObjectsFromArray:
         [CSTUser createArrayObjectsViaJSON:rawJSON :@"users" :[CSTUser getAutocompleteUserJSONStructure] :[CSTUser class]]
         ];
        
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError* error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        return nil;
    });
}

// Smart ID Searching

@end
