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



- (RXPromise *)getCollections:(CSTUser *)user
{
    return [self.shuttle launch:GET :JSON :[self.api getCollections:@"1"] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        
        NSLog(@"1. Getting Collections");
        
        if (!_collections) {
            _collections = [[NSMutableArray alloc] init];
        }
             
        NSArray *array = [CSTUser createArrayViaJSON:rawJSON :@"user/collections"];
        
        NSLog(@"2. Creating Collections");
         
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
            
            if ([collection isListenLater]) {
                _listenLaterCollection = collection;
            } else {
                [_collections addObject:collection];
            }
         }

        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError* error) {
        NSLog(@"3> Error: %@", [error localizedDescription]);
        return nil;
    });
}

- (void)getEditableCollections:(CSTUser *)user
{
    RXPromise *editCollections = [RXPromise new];
    
    if (!_collections) {
        NSLog(@"A). First Things First");
        editCollections = [self getCollections:user]
        
        .then(^id (NSDictionary *rawJSON) {
            [self _editableCollections:user];
            return @"OK";
        }, nil)
        
        .then(nil, ^id(NSError* error) {
            NSLog(@"3> Error: %@", [error localizedDescription]);
            return nil;
        });
        
    } else {
        [editCollections fulfillWithValue:@"OK"];
    }
}

- (RXPromise *)_editableCollections:(CSTUser *)user
{
    RXPromise *promise = [RXPromise new];
    
    NSLog(@"B). Getting Editable");
    [self.shuttle launch:GET :JSON :[self.api getEditableCollections:@"1"] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        NSLog(@"C). Handling Rest");
        
        NSArray *array = [CSTUser createArrayViaJSON:rawJSON :@"collections"];
        
        for (NSDictionary *object in array) {
            
            for (CSTCollection *c in  _collections) {
                if ([[c getID] isEqualToString:[NSString stringWithFormat:@"%@", [object objectForKey:@"id"]]]) {
                    [c setEditable:YES];
                } else {
                    if ([[_listenLaterCollection getID] isEqualToString:[object objectForKey:@"id"]]) {
                        [_listenLaterCollection setEditable:YES];
                    }
                }
            }
        }
        
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError* error) {
        NSLog(@"3> Error: %@", [error localizedDescription]);
        return nil;
    });
    
    return promise;
}



- (void)createCollection:(NSString *)nameOfCollection :(NSArray *)mixes :(CSTUser *)userID :(NSString *)username :(NSString *)password
{
    NSLog(@"Creating Collection...");
    
    NSString *trimmedName = [nameOfCollection stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSLog(@"...fetching...");
    
    RXPromise *createCollPromise = [RXPromise new];
    createCollPromise = [self getCollections:nil]
    
    
    .then(^id (id blank) {
        return [self _checkCollectionNameAlreadyTaken:trimmedName :createCollPromise];
    }, nil)
    
    
    .then(^id (id blank) {
        NSLog(@"All Good!");
        return [self _newCollection:trimmedName :mixes :username :password];
    }, nil)
    
    
    .then(^id (CSTCollection *collection) {
        
        NSLog(@"...Collection Created");
        return @"OK";
    }, nil)
    
    
    .then(nil, ^id(NSError* error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        return nil;
    });
}

- (RXPromise *)_newCollection:(NSString *)nameOfCollection :(NSArray *)mixes :(NSString *)username :(NSString *)password
{
    NSLog(@"Creating new collection...");
    
    NSDictionary *params = @{
                             @"collection[name]" : nameOfCollection,
                             @"mix_id"           : [NSString stringWithFormat:@"%@", [mixes[0] _id]],
                             @"login"            : username,
                             @"password"         : password
                             };
    
    
    
    return [self.shuttle launch:POST :JSON :[self.api createCollection] :params]
    
    
    .then(^id (NSDictionary *rawJSON) {
        
        // how do we know this all went well?
        
        if ([mixes count] > 1) {
            
            NSString *collectionID = [NSString stringWithFormat:@"%@", [[rawJSON objectForKey:@"collection"] objectForKey:@"id"]];
            
            for (int a = 1; a < [mixes count]; a++) {
                [self addMixToCollection:collectionID :mixes[a] :username :password];
            }
        }
        
        CSTCollection *collection = [CSTCollection createViaJSON :rawJSON :[CSTCollection getJSONStructureWithPaths]];
        [collection setMixes:[[NSMutableArray alloc] initWithArray:mixes]];
        
        return collection;
        
        return @"OK";
    }, nil)
    
    
    .then(nil, ^id(NSError* error) {
        return error;
    });
}



- (void)editCollection:(NSString *)collectionID :(NSString *)name :(NSString *)desc :(NSString *)username :(NSString *)password
{
    NSLog(@"Updating collection details...");
    
    NSString *trimmedName = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSLog(@"...fetching...");
    
    RXPromise *editCollPromise = [RXPromise new];
    editCollPromise = [self getCollections:nil]
    
    .then(^id (id blank) {
        return [self _checkCollectionNameAlreadyTaken:trimmedName :editCollPromise];
    }, nil)
    
    
    .then(^id (id blank) {
        NSLog(@"All Good!");
        return [self _updateCollection:collectionID :name :desc :username :password];
    }, nil)
    
    
    .then(^id (CSTCollection *collection) {
        NSLog(@"...Collection Updated");
        return @"OK";
    }, nil)
    
    
    .then(nil, ^id(NSError* error) {
        NSLog(@"1> Error: %@", [error localizedDescription]);
        return nil;
    });
}

- (RXPromise *)_updateCollection:(NSString *)collectionID :(NSString *)name :(NSString *)desc :(NSString *)username :(NSString *)password
{
    NSDictionary *params = @{
                             
                             @"collection[name]"        : name,
                             @"collection[description]" : desc,
                             @"login"                   : username,
                             @"password"                : password,
                             
                             };
    
    return [self.shuttle launch:PUT :JSON :[self.api updateCollection:collectionID] :params]
    
    
    .then(^id (NSDictionary *rawJSON) {
        NSLog(@"...collection details updated");
        return @"OK";
    }, nil)
    
    
    .then(nil, ^id(NSError* error) {
        NSLog(@"2> Error: %@", [error localizedDescription]);
        return error;
    });
}



- (void)deleteCollection:(CSTCollection *)collection :(NSString *)username :(NSString *)password
{
    NSLog(@"Deleting collection...");
    
    
    RXPromise *delCollPromise = [RXPromise new];
    NSDictionary *params = @{
                             
                             @"login" : username,
                             @"password" : password
                             };
    
    delCollPromise = [self.shuttle launch:DELETE :JSON :[self.api deleteCollection:[collection _id]] :params]
    
    
    .then(^id (id blank) {
        NSLog(@"...Collection Deleted!");
        return @"OK";
    }, nil)
    
    
    .then(nil, ^id(NSError* error) {
        return error;
    });
}


// before adding, need to check if not already included!

- (void)addMixToCollection:(NSString *)collectionID :(CSTBaseMix *)mix :(NSString *)username :(NSString *)password
{
    NSLog(@"Adding mix to collection...");
    
    RXPromise *addMixToCollectionPromise = [RXPromise new];
    
    NSDictionary *params = @{
                             
                             @"collection_mix[collection_id]" : collectionID,
                             @"collection_mix[mix_id]"        : [mix _id],
                             @"login"                         : username,
                             @"password"                      : password,
                             @"api_version"                   : @"3"
                             
                             };
    
    
    
    addMixToCollectionPromise = [self.shuttle launch:POST :JSON :[self.api addToCollection] :params]
    
    
    .then(^id (NSDictionary *rawJSON) {
        return @"OK";
    }, nil)
    
    
    .then(nil, ^id(NSError* error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        return error;
    });
}

- (void)removeMixFromCollection:(NSString *)collectionID :(CSTBaseMix *)mix :(NSString *)username :(NSString *)password
{
    NSLog(@"Removing mix from collection...");
    
    RXPromise *addMixToCollectionPromise = [RXPromise new];
    
    NSDictionary *params = @{
                             
                             @"collection_mix[collection_id]" : collectionID,
                             @"collection_mix[mix_id]"        : [mix _id],
                             @"login"                         : username,
                             @"password"                      : password,
                             @"api_version"                   : @"3"
                             
                             };
    
    
    
    
    addMixToCollectionPromise = [self.shuttle launch:DELETE :JSON :[self.api addToCollection] :params]
    
    
    .then(^id (NSDictionary *rawJSON) {
        return @"OK";
    }, nil)
    
    
    .then(nil, ^id(NSError* error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        return error;
    });
}



- (RXPromise *)_checkCollectionNameAlreadyTaken:(NSString *)collectionName :(RXPromise *)promise
{
    for (CSTCollection *c in _collections) {
        if ([[c name] isEqualToString:collectionName]) {
            NSLog(@"Found Same Name");
            [promise cancel];
        }
    }
    
    if ([[_listenLaterCollection name] isEqualToString:collectionName]) {
        NSLog(@"Found Same Name");
        [promise cancel];
    }
    
    [promise fulfillWithValue:@"OK"];
    
    return promise;
}

@end
