//
//  CSTParentController.m
//  Cassette
//
//  Created by Stephen Hatton on 24/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTParentController.h"

@implementation CSTParentController

- (id)init
{
    _api = [EightTracksAPI sharedManager];
    _shuttle = [Shuttle sharedManagerWithDefaults:nil];
    return self;
}

- (void)raiseError:(NSError *)error :(NSString *)klass :(NSString *)method
{
    NSLog(@"");
    NSLog(@"");
    NSLog(@"#    +------------+------------+");
    NSLog(@"#    |");
    NSLog(@"#    |   ERROR RAISED   ");
    NSLog(@"#    |   - Desc:   %@", [error localizedDescription]);
    NSLog(@"#    |   - Reason: %@", [error localizedFailureReason]);
    NSLog(@"#    |   - Class:  %@", klass);
    NSLog(@"#    |   - Method: %@", method);
    NSLog(@"#    |");
    NSLog(@"#    +------------+------------+");
    NSLog(@"");
    NSLog(@"");
}

@end
