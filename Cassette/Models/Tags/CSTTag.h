//
//  CSTTag.h
//  Cassette
//
//  Created by Stephen Hatton on 25/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSTTag : NSObject

@property (nonatomic, retain) NSString *name;



+ (NSDictionary *)getJSONStructure;

@end
