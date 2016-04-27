//
//  CSTCollectionsController.h
//  Cassette
//
//  Created by Stephen Hatton on 27/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTParentController.h"

#import "CSTBaseMix.h"
#import "CSTCollection.h"
#import "CSTUser.h"

@interface CSTCollectionsController : CSTParentController

@property (nonatomic, retain) NSMutableArray *collections;



- (void)getCollections:(CSTUser *)user;

@end
