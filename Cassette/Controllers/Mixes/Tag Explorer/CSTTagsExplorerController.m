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
    [self.shuttle launch:GET :JSON :[self.api getTopTags:[_searchSetup pageNumber] :[_searchSetup resultsPerPage]] :nil]
    
    
    .then(^id (NSDictionary *rawJSON) {
        [self _extractTags:rawJSON :@"tag_cloud/tags" :[_searchSetup pageNumber]];
        
        if (![[[rawJSON objectForKey:@"tag_cloud"] objectForKey:@"next_page"] isEqual:[NSNull null]]) {
            [_searchSetup setNumberOfResults:(([_searchSetup pageNumber] + 1) * [_searchSetup resultsPerPage])];
        }
        
        return @"OK";
    }, nil)
    
    
    .then(nil, ^id(NSError* error) {
        [self raiseError:error :x(self) :y];
        return nil;
    });
}

- (void)getTopTagsNextPage
{
    if ([_searchSetup nextPage]) {
        [self getTopTags];
    }
}



- (void)getAutocompleteTags:(NSString *)autocompleteTerm
{
    [self.shuttle launch:GET :JSON :[self.api autocompleteTags:autocompleteTerm] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        [self _extractAutocompleteTags:rawJSON :@"tag_cloud/tags" :1];
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError* error) {
        [self raiseError:error :x(self) :y];
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
    if (!_tagsSearchSetup) {
        _tagsSearchSetup = [[NSMutableArray alloc] init];
    }
    
    if (pageNumber == 1)
        [_tagsSearchSetup removeAllObjects];
    
    NSArray *tags = [CSTTag createArrayViaJSON:rawJSON :pathToTags];

    for (NSObject *obj in tags) {
        CSTTag *tag = [[CSTTag alloc] init];
        [tag setName:[obj valueForKey:@"name"]];
        [_tagsSearchSetup addObject:tag];
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
                                     :[_mixesSearchSetup pageNumber]
                                     :[_mixesSearchSetup resultsPerPage]] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        
        [self _extractTags:rawJSON :@"filters" :[_searchSetup pageNumber]];
        [self _extractMixes:rawJSON :[_mixesSearchSetup pageNumber]];
        
        [_mixesSearchSetup updateViaJSON:rawJSON :[CSTSearchSetup getJSONStructure]];

        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError* error) {
        [self raiseError:error :x(self) :y];
        return nil;
    });
}

- (void)getMixesFromTagSelectionNextPage
{
    if ([_mixesSearchSetup nextPage]) {
        [self getMixesFromTagSelection];
    }
}

@end
