//
//  CSTMixPlayer.m
//  Cassette
//
//  Created by Stephen Hatton on 24/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTMixPlayer.h"

@implementation CSTMixPlayer

- (instancetype)init
{
    self = [super init];
    return self;
}

- (void)playMix:(NSString *)mixID
{
    [self.shuttle launch:GET :JSON :[self.api playMix:mixID] :nil]
    
    
    .then(^id (NSDictionary *rawJSON) {
        NSLog(@"Raw JSON: %@", rawJSON);
        return rawJSON[@"set"][@"track"][@"track_file_stream_url"];
    }, nil)
    
    
    .thenOnMain(^id (NSString *trackURL) {
        [self playMusic:trackURL];
        return @"OK";
        
    }, nil)
    
    .then(nil, ^id(NSError* error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        return nil;
    });
}

- (void)playMusic:(NSString *)trackURL
{
    NSLog(@" ---[%@]: %s", ([NSThread isMainThread] ? @"MAIN THREAD" : @"BACKGROUND THREAD"), __PRETTY_FUNCTION__);
}

- (void)_startReportTimer
{
    
}

- (void)_stopReportTimer
{
    
}

- (void)_reportTrack:(NSObject *)trackID
{
    
}

@end
