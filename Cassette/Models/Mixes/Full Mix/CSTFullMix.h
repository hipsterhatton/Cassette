//
//  CSTFullMix.h
//  Cassette
//
//  Created by Stephen Hatton on 24/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTBaseMix.h"

@interface CSTFullMix : CSTBaseMix

@property (nonatomic) int playsCount;
@property (nonatomic) int likesCount;
@property (nonatomic) int tracksCount;

@property (nonatomic, retain) NSMutableArray *tracksPlayed;

@end
