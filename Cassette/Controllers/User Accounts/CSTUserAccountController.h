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

- (RXPromise *)logUserIn:(NSString *)username :(NSString *)password;
- (RXPromise *)logUserOut;

- (RXPromise *)toggleLikeMix:(NSString *)mixID;
- (RXPromise *)toggleFavouriteTrack:(NSString *)trackID;
- (RXPromise *)toggleFollowUser:(NSString *)userID;



@property (nonatomic, retain) CSTAppUser *appUser;

@end
