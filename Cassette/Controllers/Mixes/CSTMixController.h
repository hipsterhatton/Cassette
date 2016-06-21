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

- (RXPromise *)getMixDetails:(NSString *)mixID;
- (RXPromise *)getSimilarMixes:(CSTBaseMix *)mix;
- (RXPromise *)getTracksAlreadyPlayed:(CSTBaseMix *)mix;

@end
