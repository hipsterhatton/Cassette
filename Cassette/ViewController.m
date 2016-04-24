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
    _explorer = [[CSTMixExplorerController alloc] init];
    [_explorer getHomepageMixes];
}

- (IBAction)button_playMix:(id)sender
{
    CSTMixPlayer *player = [[CSTMixPlayer alloc] init];
    [player playMix: [_explorer homepageMixes][6] ];
}

- (IBAction)button_loadNextPage:(id)sender
{
    CSTBaseMix *mix = [[_explorer homepageMixes] firstObject];
    [_explorer getSimilarMixes:mix];
}


@end
