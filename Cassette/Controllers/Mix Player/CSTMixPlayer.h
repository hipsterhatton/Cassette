//
//  CSTMixPlayer.h
//  Cassette
//
//  Created by Stephen Hatton on 24/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <FreeStreamer/FSAudioStream.h>

#import "CSTParentController.h"

#import "CSTBaseMix.h"
#import "CSTTrack.h"

@interface CSTMixPlayer : CSTParentController

@property (nonatomic, retain) FSAudioStream *player;

@property (nonatomic, retain) CSTTrack *currentlyPlayingTrack;
@property (nonatomic, retain) CSTBaseMix *currentlyPlayingMix;

@property (nonatomic, retain) NSTimer *reportingTimer;
@property (nonatomic) int reportingTimerCounter;

// need to pass thru the mix...

- (void)playMix:(NSString *)mixID;

@end
