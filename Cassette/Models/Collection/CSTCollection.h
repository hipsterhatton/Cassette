//
//  CSTCollection.h
//  Cassette
//
//  Created by Stephen Hatton on 26/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSTParentModel.h"

@interface CSTCollection : CSTParentModel

@property (nonatomic, retain) NSString *_id;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *_description;
@property (nonatomic, retain) NSString *smart_id;
@property (nonatomic, retain) NSMutableArray *mixes;
@property (nonatomic) BOOL editable;



- (BOOL)isListenLater;

+ (NSDictionary *)getJSONStructure;
+ (NSDictionary *)getJSONStructureWithPaths;

@end
