//
//  CSTSearchSetup.h
//  Cassette
//
//  Created by Stephen Hatton on 24/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSTSearchSetup : NSObject

typedef enum {
  SearchSetupSmartIDArtist,
  SearchSetupSmartIDKeyword,
    
  SearchSetupSmartIDFeed,
  SearchSetupSmartIDSocialFeed,
  SearchSetupSmartIDSocialListened,
  SearchSetupSmartIDSocialRecommended
} SearchSetupSmartID;

@property (nonatomic) int pageNumber;
@property (nonatomic) int numberOfResults;
@property (nonatomic) int resultsPerPage;
@property (nonatomic, retain) NSString *sort;
@property (nonatomic) SearchSetupSmartID searchSmartID;



- (BOOL)nextPage;
- (BOOL)previousPage;

+ (NSDictionary *)getJSONStructure;
+ (NSDictionary *)getAltJSONStructure;

@end
