//
//  EightTracksAPI.h
//  Cassette
//
//  Created by Stephen Hatton on 24/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EightTracksAPI : NSObject

+ (id)sharedManager;

- (NSString *)getAPIversion;
- (NSString *)getAPIkey;

- (NSString *)getHomepageMixes;

@end
