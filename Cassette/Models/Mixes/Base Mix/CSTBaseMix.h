//
//  CSTBaseMix.h
//  Cassette
//
//  Created by Stephen Hatton on 24/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+DavidJSON.h"

@interface CSTBaseMix : NSObject

@property (nonatomic, strong) NSString *_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *tagList;
@property (nonatomic, strong) NSString *certification;
@property (nonatomic, strong) NSString *coverImageURL;
@property (nonatomic) int duration;
@property (nonatomic) BOOL nsfw;
@property (nonatomic) BOOL likedByUser;

+ (NSDictionary *)getJSONStructure;

@end
