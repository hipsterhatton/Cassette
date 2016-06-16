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

#define x(k) NSStringFromClass([k class])
#define y NSStringFromSelector(_cmd)

@interface CSTParentController : NSObject

@property (nonatomic, retain) EightTracksAPI *api;
@property (nonatomic, retain) Shuttle *shuttle;



- (void)raiseError:(NSError *)error :(NSString *)klass :(NSString *)method;

@end
