//
//  CSTTagsExplorerController.h
//  Cassette
//
//  Created by Stephen Hatton on 25/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTMixController.h"
#import "CSTSearchSetup.h"
#import "CSTTag.h"

@interface CSTTagsExplorerController : CSTMixController

@property (nonatomic, retain) CSTSearchSetup *searchSetup;
@property (nonatomic, retain) NSMutableArray *tags;

@property (nonatomic, retain) NSMutableArray *autocompleteTags;

// could use another search setup for the mixes...

@property (nonatomic, retain) CSTSearchSetup *mixesSearchSetup;
@property (nonatomic, retain) NSMutableArray *selectedTags;
@property (nonatomic, retain) NSMutableArray *selectedTagsMixes;


- (void)getTopTags;
- (void)topTagsNextPage;

- (void)getAutocompleteTags:(NSString *)autocompleteTerm;

- (void)addSelectedTag:(CSTTag *)tag;
- (void)removeSelectedTag:(int)pos;

- (void)getMixesFromTagSelection;
- (void)tagMixesNextPage;

@end
