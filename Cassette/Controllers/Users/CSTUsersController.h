//
//  CSTUsersController.h
//  Cassette
//
//  Created by Stephen Hatton on 26/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTParentController.h"
#import "CSTUser.h"

@interface CSTUsersController : CSTParentController

@property (nonatomic, retain) CSTUser *user;



- (void)getUserDetails:(NSString *)userID;

@end
