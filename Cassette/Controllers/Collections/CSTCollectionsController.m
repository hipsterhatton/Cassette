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



- (void)createCollection:(NSString *)nameOfCollection :(NSArray *)mixes :(CSTUser *)userID :(NSString *)username :(NSString *)password
{
    // 1. Fetch list    2. Iterate list - make sure no matches!     3. Send off then :D
    
    NSLog(@"Creating Collection...");
    
    
    NSString *trimmedName = [nameOfCollection stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    RXPromise *createCollPromise = [RXPromise new];
    createCollPromise = [self _newCollection:trimmedName :mixes :username :password]
    
    
    .then(^id (CSTCollection *collection) {
        NSLog(@"...Collection Created");
        return @"OK";
    }, nil)
    
    
    .then(nil, ^id(NSError* error) {
        return nil;
    });
}

- (RXPromise *)_newCollection:(NSString *)nameOfCollection :(NSArray *)mixes :(NSString *)username :(NSString *)password
{
    NSLog(@"Creating new collection...");
    
    NSDictionary *params = @{
                             @"collection[name]" : nameOfCollection,
                             @"mix_id"           : [mixes[0] getID],
                             @"login"            : username,
                             @"password"         : password
                             };
    
    return [self.shuttle launch:POST :JSON :@"something_goes_here" :params]
    
    
    .then(^id (NSDictionary *rawJSON) {
        
//        if ([mixes count] >= 2) {
//            
//            NSString *collectionID = stringify([[rawJSON objectForKey:@"collection"] objectForKey:@"id"]);
//            
//            for (int a = 1; a < [mixes count]; a++) {
//                [self addMixToCollection:collectionID :mixes[a] :username :password];
//            }
//        }
//        
//        CSTEightTracksCollection *collection = [CSTEightTracksCollection createViaJSON
//                                                :rawJSON :[CSTEightTracksCollection getJSONStructureWithPaths]];
//        
//        
//        [collection addMixes:mixes];
        
//        return collection;
        
        return @"OK";
    }, nil)
    
    
    .then(nil, ^id(NSError* error) {
        return error;
    });
}

- (void)editCollection:(CSTCollection *)collection
{
    
}

- (void)deleteCollection:(CSTCollection *)collection
{
    
}

@end
