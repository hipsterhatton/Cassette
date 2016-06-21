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
    [self setupApplication];
}

- (void)setRepresentedObject:(id)representedObject
{
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (RXPromise *)setupApplication
{
    _api = [EightTracksAPI sharedManager];
    
    _shuttle = [Shuttle sharedManagerWithDefaults:@{
                                                    @"X-Api-Key"      : [_api getAPIkey],
                                                    @"X-Api-Version"  : [_api getAPIversion]
                                                    }];
    
    return [self.shuttle launch:GET :JSON :@"testing" :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        [_api setPlayToken:rawJSON[@"play_token"]];
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        return error;
    });
}

- (void)loadMixExplorer
{
    CSTMixController *xyz = [[CSTMixController alloc] init];
    [xyz getMixDetails:@"1"];
}

- (IBAction)button_playMix:(id)sender
{
    [_searcher autocompleteSearch:@"coff"];
}

- (IBAction)button_loadNextPage:(id)sender
{
    
}

@end
