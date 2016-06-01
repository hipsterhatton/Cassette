//
//  CSTSearchingController.h
//  Cassette
//
//  Created by Stephen Hatton on 01/06/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTParentController.h"
#import "CSTBaseMix.h"
#import "CSTSearchSetup.h"
#import "CSTUser.h"

@interface CSTSearchingController : CSTParentController

@property (nonatomic, retain) CSTSearchSetup *searchSetup;
@property (nonatomic, retain) NSMutableArray *mixes;
@property (nonatomic, retain) NSMutableArray *users;


- (void)autocompleteSearch:(NSString *)searchTerm;

@end
