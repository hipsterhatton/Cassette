//
//  CSTUserAccountController.h
//  Cassette
//
//  Created by Stephen Hatton on 24/06/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTParentController.h"

@interface CSTUserAccountController : CSTParentController

- (RXPromise *)logUserIn:(NSString *)username :(NSString *)password;
- (RXPromise *)logUserOut;

@end
