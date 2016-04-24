//
//  CSTParentController.h
//  Cassette
//
//  Created by Stephen Hatton on 24/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EightTracksAPI.h"
#import "Shuttle.h"

@interface CSTParentController : NSObject

@property (nonatomic, retain) EightTracksAPI *api;
@property (nonatomic, retain) Shuttle *shuttle;

@end
