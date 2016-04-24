//
//  ViewController.m
//  Cassette
//
//  Created by Stephen Hatton on 21/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "ViewController.h"
#import "Shuttle.h"

#import "CSTMixExplorerController.h"
#import "CSTMixPlayer.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setRepresentedObject:(id)representedObject
{
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)setup
{
    _api = [EightTracksAPI sharedManager];
    
    _shuttle = [Shuttle sharedManagerWithDefaults:@{
                                                    @"X-Api-Key"      : [_api getAPIkey],
                                                    @"X-Api-Version"  : [_api getAPIversion]
                                                    }];
    
    [self.shuttle launch:GET :JSON :[_api playToken] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        [_api setPlayToken:rawJSON[@"play_token"]];
        NSLog(@"Set Play Token!");
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError* error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        return nil;
    });
    
    [self loadMixExplorer];
}

- (void)loadMixExplorer
{
    CSTMixExplorerController *explorer = [[CSTMixExplorerController alloc] init];
    
    [explorer getHomepageMixes];
}

- (IBAction)button_playMix:(id)sender
{
    NSString *trackURL = @"http://cft.8tracks.com/tf/000/000/025/hgQEis.48k.v3.m4a";
    
//    NSURL *url = [[NSURL alloc] initWithString:trackURL];
//    
//    url = [NSURL URLWithString:trackURL];
//    
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    
//    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:nil];
//    
//    [audioPlayer play];

    
    NSURL *url = [NSURL URLWithString:trackURL];

    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
                  
    _player = [AVPlayer playerWithPlayerItem:playerItem];
    
    
//    NSLog(@"Something!");
//    
//    CSTMixPlayer *player = [[CSTMixPlayer alloc] init];
//    
//    [player playMix:@"14"];
}

@end
