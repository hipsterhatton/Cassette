//
//  CSTUserAccountController.h
//  Cassette
//
//  Created by Stephen Hatton on 24/06/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTParentController.h"

#import "CSTAppUser.h"
#import "CSTBaseMix.h"

@interface CSTUserAccountController : CSTParentController

- (RXPromise *)logUserin_v2:(NSString *)username :(NSString *)password;
- (RXPromise *)logUserout_v2:(NSString *)username;

- (RXPromise *)toggleLikeMix:(NSString *)mixID;
- (RXPromise *)toggleFavouriteTrack:(NSString *)trackID;
- (RXPromise *)toggleFollowUser:(NSString *)userID;



@property (nonatomic, retain) CSTAppUser *appUser;

@end
