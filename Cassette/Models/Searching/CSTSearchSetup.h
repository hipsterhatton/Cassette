//
//  CSTSearchSetup.h
//  Cassette
//
//  Created by Stephen Hatton on 24/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSTSearchSetup : NSObject

@property (nonatomic) int pageNumber;
@property (nonatomic) int numberOfResults;
@property (nonatomic) int resultsPerPage;
@property (nonatomic, retain) NSString *sort;



- (BOOL)nextPage;
- (BOOL)previousPage;

+ (NSDictionary *)getJSONStructure;

@end
