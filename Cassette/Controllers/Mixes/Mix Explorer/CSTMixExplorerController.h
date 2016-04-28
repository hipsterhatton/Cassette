//
//  CSTMixExplorerController.h
//  Cassette
//
//  Created by Stephen Hatton on 24/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTMixController.h"
#import "CSTSearchSetup.h"

@interface CSTMixExplorerController : CSTMixController

@property (nonatomic, retain) NSMutableArray *homepageMixes;
@property (nonatomic, retain) CSTSearchSetup *mixesSearchSetup;



- (void)getHomepageMixes;
- (void)getHomepageMixesNextPage;

@end
