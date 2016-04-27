//
//  CSTCollectionsController.m
//  Cassette
//
//  Created by Stephen Hatton on 27/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTCollectionsController.h"

@implementation CSTCollectionsController

- (instancetype)init
{
    self = [super init];
    return self;
}



- (void)getCollections:(CSTUser *)user
{
    [self.shuttle launch:GET :JSON :[self.api getCollections:@"1"] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        
        if (!_collections) {
            _collections = [[NSMutableArray alloc] init];
        }
             
        NSArray *array = [CSTUser createArrayViaJSON:rawJSON :@"user/collections"];
         
        for (NSDictionary *object in array) {
            
            CSTCollection *collection = [CSTCollection createViaJSON:object :[CSTCollection getJSONStructure]];
             
            [collection setMixes:[[NSMutableArray alloc] init]];
             
            NSArray *mixes = [CSTBaseMix createArrayObjectsViaJSON
                              :object
                              :@"mixes"
                              :[CSTBaseMix getJSONStructure]
                              :[CSTBaseMix class]
                              ];
             
            [[collection mixes] addObjectsFromArray: mixes ];
            
            [_collections addObject:collection];
         }
        
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError* error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        return nil;
    });
}

- (void)createCollection:(CSTCollection *)collection
{
    
}

@end
