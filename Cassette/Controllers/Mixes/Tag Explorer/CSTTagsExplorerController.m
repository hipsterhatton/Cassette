//
//  CSTTagsExplorerController.m
//  Cassette
//
//  Created by Stephen Hatton on 25/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTTagsExplorerController.h"
#import "CSTTag.h"

@implementation CSTTagsExplorerController

- (instancetype)init
{
    self = [super init];
    _searchSetup = [[CSTSearchSetup alloc] init];
    _mixesSearchSetup = [[CSTSearchSetup alloc] init];
    return self;
}



- (void)getTopTags
{
    [self.shuttle launch:GET :JSON :[self.api getTopTags:[_searchSetup pageNumber]] :nil]
    
    
    .then(^id (NSDictionary *rawJSON) {
        
        [self _extractTags:rawJSON :@"tag_cloud/tags" :[_searchSetup pageNumber]];
        
        return @"OK";
    }, nil)
    
    
    .then(nil, ^id(NSError* error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        return nil;
    });
}

- (void)topTagsNextPage
{
    if ([_searchSetup nextPage]) {
        
    }
    
    [_searchSetup setPageNumber:2];
    [self getTopTags];
}



- (void)getAutocompleteTags:(NSString *)autocompleteTerm
{
    [self.shuttle launch:GET :JSON :[self.api autocompleteTags:autocompleteTerm] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        
        NSLog(@"Raw JSON: %@", rawJSON);
        
        [self _extractAutocompleteTags:rawJSON :@"tag_cloud/tags" :1];
        
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError* error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        return nil;
    });
}



- (void)addSelectedTag:(CSTTag *)tag
{
    if (!_selectedTags) {
        _selectedTags = [[NSMutableArray alloc] init];
    } else {
        if ([_selectedTags count] == 3) {
            NSLog(@"Too many tags added");
            return;
        }
    }
    
    [_selectedTags addObject:tag];
    
    [self getMixesFromTagSelection];
}

- (void)removeSelectedTag:(int)pos
{
    [_selectedTags removeObjectAtIndex:pos];
    
    if ([_selectedTags count] == 0) {
        return;
    }
    
    [self getMixesFromTagSelection];
}



- (void)_extractTags:(NSDictionary *)rawJSON :(NSString *)pathToTags :(int)pageNumber
{
    if (!_tags) {
        _tags = [[NSMutableArray alloc] init];
    }
    
    if (pageNumber == 1)
        [_tags removeAllObjects];
    
    NSArray *tags = [CSTTag createArrayViaJSON:rawJSON :pathToTags];
    
    for (NSObject *obj in tags) {
        CSTTag *tag = [[CSTTag alloc] init];
        [tag setName:[obj valueForKey:@"name"]];
        [_tags addObject:tag];
    }
}

- (void)_extractAutocompleteTags:(NSDictionary *)rawJSON :(NSString *)pathToTags :(int)pageNumber
{
    if (!_autocompleteTags) {
        _autocompleteTags = [[NSMutableArray alloc] init];
    }
    
    if (pageNumber == 1)
        [_autocompleteTags removeAllObjects];
    
    NSArray *tags = [CSTTag createArrayViaJSON:rawJSON :pathToTags];
    
    for (NSObject *obj in tags) {
        CSTTag *tag = [[CSTTag alloc] init];
        [tag setName:[obj valueForKey:@"name"]];
        [_autocompleteTags addObject:tag];
    }
}

- (void)_extractMixes:(NSDictionary *)rawJSON :(int)pageNumber
{
    if (!_selectedTagsMixes) {
        _selectedTagsMixes = [[NSMutableArray alloc] init];
    }
    
    if (pageNumber == 1)
        [_selectedTagsMixes removeAllObjects];
    
    [_selectedTagsMixes addObjectsFromArray:[CSTBaseMix createArrayObjectsViaJSON
                                               :rawJSON
                                               :@"mix_set/mixes"
                                               :[CSTBaseMix getJSONStructure]
                                               :[CSTBaseMix class]]
     ];
}



- (void)getMixesFromTagSelection
{
    NSMutableArray *tagStrings = [[NSMutableArray alloc] init];
    for (CSTTag *t in _selectedTags) {
        [tagStrings addObject:[t name]];
    }
 
    [self.shuttle launch:GET :JSON :[self.api getTagsAndMixes
                                     :[tagStrings componentsJoinedByString:@"+"]
                                     :[_mixesSearchSetup pageNumber]] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        
        [self _extractTags:rawJSON :@"filters" :[_searchSetup pageNumber]];
        [self _extractMixes:rawJSON :[_mixesSearchSetup pageNumber]];
        
        [_mixesSearchSetup updateViaJSON:rawJSON :[CSTSearchSetup getJSONStructure]];
        
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError* error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        return nil;
    });
}

- (void)tagMixesNextPage
{
    if ([_mixesSearchSetup nextPage]) {
        [self getMixesFromTagSelection];
    }
}

@end
