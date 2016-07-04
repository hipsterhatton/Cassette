//
//  CSTUserAccountController.m
//  Cassette
//
//  Created by Stephen Hatton on 24/06/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTUserAccountController.h"

@implementation CSTUserAccountController

- (instancetype)init
{
    self = [super init];
    return self;
}



- (RXPromise *)logUserIn:(NSString *)username :(NSString *)password
{
    
    return [self _logUserOut:username]
    
    
    .then(^id (id blank) {
        return [self _logUserIn:username :password];
    }, nil)
    
    
    .then(nil, ^id(NSError *error) {
        [self raiseError:error :x(self) :y];
        return error;
    });
}

- (RXPromise *)_logUserIn:(NSString *)username :(NSString *)password
{
    NSDictionary *logInDetails = @{ @"login" : username,
                                    @"password" : password,
                                    @"api_version" : @"3" };
    
    return [self.shuttle launch:POST :JSON :[self.api logUserIn] :logInDetails]
    
    
    .then(^id (NSDictionary *rawJSON) {
        
        NSLog(@"Raw JSON: %@", rawJSON);
        
        _appUser = [CSTAppUser createViaJSON:rawJSON :[CSTAppUser getLoggedInUserJSONStructure]];

        return [[rawJSON objectForKey:@"user"] objectForKey:@"user_token"];
    }, nil)
    
    
    .thenOnMain(^id (NSString *userToken) {
        [self.shuttle updateDefaults:@{ @"X-User-Token" : userToken }];
        return nil;
    }, nil)
    
    
    .then(nil, ^id(NSError *error) {
        [self raiseError:error :x(self) :y];
        return error;
    });
}

- (RXPromise *)logUserOut
{
    
    return [self _logUserOut:@"HipsterHatton"]
    
    .thenOnMain(^id (id blank) {
        [self.shuttle updateDefaults:@{ @"X-User-Token" : @"" }];
        return nil;
    }, nil)
    
    .then(nil, ^id(NSError *error) {
        [self raiseError:error :x(self) :y];
        return error;
    });
}

- (RXPromise *)_logUserOut:(NSString *)username
{
    return [self.shuttle launch:POST :HTTP :[self.api logUserOut] :@{ @"login" : username, @"api_version" : @"3" }]
    
    
    .then(^id (NSDictionary *rawJSON) {
        _appUser = nil;
        return @"OK";
    }, nil)
    
    
    .then(nil, ^id(NSError *error) {
        [self raiseError:error :x(self) :y];
        return error;
    });
}




- (RXPromise *)toggleLikeMix:(NSString *)mixID
{
    return [self.shuttle launch:GET :JSON :[self.api toggleLikeMix:mixID] :nil]
    
    .then(^id (NSDictionary *rawJSON) {

        if ([[[rawJSON objectForKey:@"mix"] objectForKey:@"liked_by_current_user"] boolValue] == true) {
            [_appUser addLikedMix:rawJSON];
        } else {
            [_appUser removeLikedMix:rawJSON];
        }
        
        return @"OK";
    }, nil)

    .then(nil, ^id(NSError *error) {
        [self raiseError:error :x(self) :y];
        return error;
    });
}

- (RXPromise *)toggleFavouriteTrack:(NSString *)trackID
{
    return [self.shuttle launch:GET :JSON :[self.api toggleFavouriteTrack:trackID] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        
        if ([[[rawJSON objectForKey:@"track"] objectForKey:@"faved_by_current_user"] boolValue] == true) {
            [_appUser addLikedMix:rawJSON];
        } else {
            [_appUser removeLikedMix:rawJSON];
        }
        
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError *error) {
        [self raiseError:error :x(self) :y];
        return error;
    });
}

- (RXPromise *)toggleFollowUser:(NSString *)userID
{
    return [self.shuttle launch:GET :JSON :[self.api toggleFollowUser:userID] :nil]
    
    .then(^id (NSDictionary *rawJSON) {
        
        if ([[[rawJSON objectForKey:@"user"] objectForKey:@"followed_by_current_user"] boolValue] == true) {
            [_appUser addLikedMix:rawJSON];
        } else {
            [_appUser removeLikedMix:rawJSON];
        }
        
        return @"OK";
    }, nil)
    
    .then(nil, ^id(NSError *error) {
        [self raiseError:error :x(self) :y];
        return error;
    });
}




- (RXPromise *)signUserUp :(NSString *)username :(NSString *)password
{
    return nil;
//    NSLog(@"Signing User Up...");
//    
//    NSDictionary *params = @{
//                             @"user[login]"     : @"remitest",
//                             @"user[password]"  : @"password",
//                             @"user[email]"     : @"remitest@8tracks.com",
//                             @"user[agree_to_terms]" : @"1"
//                             };
//    
//    return [self.rocket launch:POST :JSON :@"https://8tracks.com/users.json" :params]
//    
//    
//    
//    .then(^id (NSDictionary *rawJSON) {
//        
//        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[CSTEightTracksUser getUserJSONStructure]];
//        [dict addEntriesFromDictionary:[CSTEightTracksAppUser getUserJSONStructure]];
//        self.appUser = [CSTEightTracksAppUser createViaJSON:rawJSON :dict];
//        
//        NSArray *d1 = [[rawJSON objectForKey:@"user"] objectForKey:@"presets"];
//        NSArray *d2 = [[rawJSON objectForKey:@"user"] objectForKey:@"preset_smart_ids"];
//        [self.appUser setupPresets:d1 :d2];
//        
//        NSLog(@" ---[...Sign Up Successful!]: %s", __PRETTY_FUNCTION__);
//        return @"OK";
//    }, nil)
//    
//    
//    .thenOnMain(^id (id blank) {
//        [self.rocket updateDefaults:@{ @"X-User-Token" : [self.appUser token] }];
//        return nil;
//    }, nil)
//    
//    
//    .then(nil, ^id(NSError* error) {
//        ADD_ERROR(error, @"Sign User Up");
//        return error;
//    });
}

@end
