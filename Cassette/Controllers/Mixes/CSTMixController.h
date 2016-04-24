//
//  CSTMixController.h
//  Cassette
//
//  Created by Stephen Hatton on 24/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTParentController.h"

#import "CSTBaseMix.h"
#import "CSTTrack.h"

@interface CSTMixController : CSTParentController

- (void)getMixDetails:(NSString *)mixID;
- (void)getSimilarMixes:(CSTBaseMix *)mix;
- (void)getTracksAlreadyPlayed:(CSTBaseMix *)mix;

@end
