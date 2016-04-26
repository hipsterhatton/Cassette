//
//  ViewController.h
//  Cassette
//
//  Created by Stephen Hatton on 21/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "EightTracksAPI.h"
#import "Shuttle.h"

#import "CSTMixExplorerController.h"
#import "CSTTagsExplorerController.h"
#import "CSTUsersController.h"

#import "CSTTag.h"

@interface ViewController : NSViewController

@property (nonatomic, retain) EightTracksAPI *api;
@property (nonatomic, retain) Shuttle *shuttle;

@property (nonatomic, retain) CSTMixExplorerController *explorer;
@property (nonatomic, retain) CSTTagsExplorerController *tagexplorer;
@property (nonatomic, retain) CSTUsersController *users;

@end

