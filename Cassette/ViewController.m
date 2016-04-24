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
    
    CSTMixExplorerController *explorer = [[CSTMixExplorerController alloc] init];
    
    [explorer getHomepageMixes];
}

@end
