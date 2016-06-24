//
//  CSTUser.h
//  Cassette
//
//  Created by Stephen Hatton on 26/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "NSObject+DavidJSON.h"

#import <Foundation/Foundation.h>

#import "CSTSearchSetup.h"


@interface CSTUser : NSObject

@property (nonatomic, retain) NSString *_id;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *avatar;

@property (nonatomic, retain) NSMutableArray *followers;
@property (nonatomic, retain) CSTSearchSetup *followersSearchSetup;

@property (nonatomic, retain) NSMutableArray *following;
@property (nonatomic, retain) CSTSearchSetup *followingSearchSetup;

@property (nonatomic, retain) NSMutableArray *collections;
@property (nonatomic, retain) CSTSearchSetup *collectionsSearchSetup;

@property (nonatomic, retain) NSMutableArray *madeMixes;
@property (nonatomic, retain) CSTSearchSetup *madeMixesSearchSetup;

@property (nonatomic, retain) NSMutableArray *likedMixes;
@property (nonatomic, retain) CSTSearchSetup *likedMixesSearchSetup;

@property (nonatomic, retain) NSMutableArray *likedTracks;
@property (nonatomic, retain) CSTSearchSetup *likedTracksSearchSetup;



- (NSString *)getID;

+ (NSDictionary *)getUserJSONStructure;
+ (NSDictionary *)getLoggedInUserJSONStructure;
+ (NSDictionary *)getFollowingOrFollowersUserJSONStructure;
+ (NSDictionary *)getAutocompleteUserJSONStructure;

@end
