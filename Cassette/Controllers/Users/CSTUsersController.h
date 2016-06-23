//
//  CSTUsersController.h
//  Cassette
//
//  Created by Stephen Hatton on 26/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTParentController.h"

#import "CSTBaseMix.h"
#import "CSTCollection.h"
#import "CSTTrack.h"
#import "CSTUser.h"

@interface CSTUsersController : CSTParentController

@property (nonatomic, retain) CSTUser *user;



- (RXPromise *)getUserDetails:(NSString *)userID;
- (RXPromise *)getUserMixes:(CSTUser *)user;

- (RXPromise *)getLikedMixes:(CSTUser *)user;
- (RXPromise *)getLikedTracks:(CSTUser *)user;

- (RXPromise *)getUserFollowers:(CSTUser *)user;
- (RXPromise *)getUserFollowing:(CSTUser *)user;

@end
