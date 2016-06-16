//
//  ViewController.m
//  Cassette
//
//  Created by Stephen Hatton on 21/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "ViewController.h"
#import "Shuttle.h"

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
    _collections = [[CSTCollectionsController alloc] init];
    
//    CSTBaseMix *mix = [[CSTBaseMix alloc] init];
//    [mix set_id:@"14"];
//    
//    CSTBaseMix *mix2 = [[CSTBaseMix alloc] init];
//    [mix2 set_id:@"7952422"];
//    
//    CSTBaseMix *mix3 = [[CSTBaseMix alloc] init];
//    [mix3 set_id:@"5409204"];
    
//    [_collections createCollection:@"testingCollection" :@[mix,mix2] :nil :@"HipsterHatton" :@"newspaper1"];
    
//    CSTCollection *collection = [[CSTCollection alloc] init];
//    [collection set_id:@"88166830"];
//    [_collections deleteCollection:collection :@"HipsterHatton" :@"newspaper1"];
    
//    [_collections addMixToCollection:@"88166878" :mix3 :@"HipsterHatton" :@"newspaper1"];
//    [_collections removeMixFromCollection:@"88166878" :mix :@"HipsterHatton" :@"newspaper1"];
    
//    [_collections editCollection:@"88166878" :@"NewName2" :@"Desc2" :@"HipsterHatton" :@"newspaper1"];
    
    [_collections getEditableCollections:nil];
}

- (IBAction)button_playMix:(id)sender
{
    
}

- (IBAction)button_loadNextPage:(id)sender
{
    
}

@end
