//
//  CSTMixPlayer.h
//  Cassette
//
//  Created by Stephen Hatton on 24/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "CSTParentController.h"

@interface CSTMixPlayer : CSTParentController

- (void)playMix:(NSString *)mixID;

@end
