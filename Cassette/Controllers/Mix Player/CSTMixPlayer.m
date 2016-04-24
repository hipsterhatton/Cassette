//
//  CSTMixPlayer.m
//  Cassette
//
//  Created by Stephen Hatton on 24/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTMixPlayer.h"

@implementation CSTMixPlayer

- (instancetype)init
{
    self = [super init];
    _player = [[FSAudioStream alloc] init];
    
    [_player setStrictContentTypeChecking:NO];
    
    void (^trackFinishedBlock)(void) = ^{ [self nextTrack]; };
    
    [_player setOnCompletion:trackFinishedBlock];
    
    return self;
}



- (void)playMix:(CSTFullMix *)mix
{
    _currentlyPlayingMix = mix;

    
    [self.shuttle launch:GET :JSON :[self.api playMix:[_currentlyPlayingMix _id]] :nil]
    
    
    .then(^id (NSDictionary *rawJSON) {
        
        if (!_currentlyPlayingTrack) {
            _currentlyPlayingTrack = [CSTTrack createViaJSON:rawJSON :[CSTTrack getJSONStructure]];
        } else {
            [_currentlyPlayingTrack updateViaJSON:rawJSON :[CSTTrack getJSONStructure]];
        }
        
        NSLog(@"At End: %d", [_currentlyPlayingTrack atTheEnd]);
        NSLog(@"At Last Track: %d", [_currentlyPlayingTrack atTheLastTrack]);
        NSLog(@"Can Skip: %d", [_currentlyPlayingTrack isSkipAllowed]);
        
        return @"OK";
    }, nil)
    
    
    .thenOnMain(^id (id object) {
        [_player playFromURL:[NSURL URLWithString:[_currentlyPlayingTrack trackURL]]];
        [self _startReportTimer];
        return @"OK";
    }, nil)
    
    
    .then(nil, ^id(NSError* error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        return nil;
    });
}

- (void)nextTrack
{
    NSLog(@"Loading the next track...");
    
    [self.shuttle launch:GET :JSON :[self.api nextTrackInMix:[_currentlyPlayingMix _id]] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        [_currentlyPlayingTrack updateViaJSON:rawJSON :[CSTTrack getJSONStructure]];
        
        NSLog(@"At End: %d", [_currentlyPlayingTrack atTheEnd]);
        NSLog(@"At Last Track: %d", [_currentlyPlayingTrack atTheLastTrack]);
        NSLog(@"Can Skip: %d", [_currentlyPlayingTrack isSkipAllowed]);
        
        return @"OK";
    }, nil)
    
    .thenOnMain(^id (id object) {
        [_player playFromURL:[NSURL URLWithString:[_currentlyPlayingTrack trackURL]]];
        [self _startReportTimer];
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError* error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        return nil;
    });
}




- (void)_startReportTimer
{
    _reportingTimerCounter = 0;
    
    _reportingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                       target:self
                                                     selector:@selector(_reportTrack)
                                                     userInfo:nil
                                                      repeats:YES];
}

- (void)_stopTimer
{
    [_reportingTimer invalidate];
    _reportingTimer = nil;
}

- (void)_reportTrack
{
    _reportingTimerCounter++;
    
    NSLog(@"...: %d", _reportingTimerCounter);
    
    if (_reportingTimerCounter == 30) {
        
        NSLog(@"Reporting Timer");
        
        [self.shuttle launch:GET :JSON :[self.api reportTrack:[_currentlyPlayingTrack _id] :[_currentlyPlayingMix _id]] :nil]
        
        .then(^id (NSDictionary *rawJSON) {
            NSLog(@"Raw JSON: %@", rawJSON);
            _reportingTimerCounter = 0;
            return @"OK";
        }, nil)
        
        .then(nil, ^id(NSError* error) {
            NSLog(@"Error: %@", [error localizedDescription]);
            return nil;
        });

        [self _stopTimer];
    }
}

@end