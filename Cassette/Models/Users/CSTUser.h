//
//  CSTUser.h
//  Cassette
//
//  Created by Stephen Hatton on 26/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSObject+DavidJSON.h"

@interface CSTUser : NSObject

@property (nonatomic, retain) NSString *_id;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *avatar;

@property (nonatomic, retain) NSMutableArray *collections;

@property (nonatomic, retain) NSMutableDictionary *presets;

@property (nonatomic, retain) NSMutableDictionary *madeMixes;

@property (nonatomic, retain) NSMutableArray *followers;
@property (nonatomic, retain) NSMutableArray *following;

@property (nonatomic, retain) NSMutableDictionary *faveTracks;



+ (NSDictionary *)getUserJSONStructure;
+ (NSDictionary *)getFollowingOrFollowersUserJSONStructure;

@end
