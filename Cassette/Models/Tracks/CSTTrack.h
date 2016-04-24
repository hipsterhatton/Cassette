//
//  CSTTrack.h
//  Cassette
//
//  Created by Stephen Hatton on 24/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSObject+DavidJSON.h"

@interface CSTTrack : NSObject

@property (nonatomic, strong) NSString *_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *performer;
@property (nonatomic, strong) NSString *trackURL;
@property (nonatomic) BOOL likedByUser;

@property (nonatomic) BOOL atBeginning;
@property (nonatomic, getter=atTheLastTrack) BOOL atLastTrack;
@property (nonatomic, getter=atTheEnd) BOOL atEnd;
@property (nonatomic, getter=isSkipAllowed) BOOL skipAllowed;



+ (NSDictionary *)getJSONStructure;
+ (NSDictionary *)getAltJSONStructure;

@end
