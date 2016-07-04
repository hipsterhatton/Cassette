//
//  CSTAppUser.h
//  Cassette
//
//  Created by Stephen Hatton on 24/06/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTUser.h"
#import "CSTBaseMix.h"
#import "CSTTrack.h"

@interface CSTAppUser : CSTUser

@property (nonatomic) BOOL loggedIn;



- (BOOL)isUserLoggedIn;

- (void)addLikedMix:(NSDictionary *)rawJSON;
- (void)removeLikedMix:(NSDictionary *)rawJSON;

- (void)addLikedTrack:(NSDictionary *)rawJSON;
- (void)removeLikedTrack:(NSDictionary *)rawJSON;

- (void)addFollowedUser:(NSDictionary *)rawJSON;
- (void)removeFollowedUser:(NSDictionary *)rawJSON;

@end
