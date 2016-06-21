//
//  MixesControllerTest.m
//  Cassette
//
//  Created by Stephen Hatton on 21/06/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CSTMixController.h"
#import "ViewController.h"

#import "CSTBaseMix.h"

@interface MixesControllerTest : XCTestCase
@property (nonatomic, retain) CSTMixController *contr;
@property (nonatomic, retain) ViewController *vc;
@end

@implementation MixesControllerTest

- (void)setUp {
    [super setUp];
    _vc = [ViewController new];
    _contr = [CSTMixController new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInit
{
    XCTAssertNotNil(_contr.api);
    XCTAssertNotNil(_contr.shuttle);
}

- (void)testGetMixDetails
{
    RXPromise *p = [_contr getMixDetails:@"14"];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should get mix details"];
    
    p.then(^id (id o) {
        [expectation fulfill];
        return @"OK";
    }, nil);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Test Error: %@", [error localizedDescription]);
        }
    }];
}

- (void)testGetSimilarMixes
{
    CSTBaseMix *mix = [CSTBaseMix new];
    [mix set_id:@"14"];
     
    RXPromise *p = [_contr getSimilarMixes:mix];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should get similar mixes"];
    
    p.then(^id (id o) {
        [expectation fulfill];
        
        XCTAssertNotNil([mix similarMixes]);
        XCTAssertGreaterThanOrEqual([[mix similarMixes] count], 1);
        
        XCTAssertNotNil([[[mix similarMixes] firstObject] objectForKey:@"_id"]);
        XCTAssertNotNil([[[mix similarMixes] firstObject] objectForKey:@"name"]);
        XCTAssertNotNil([[[mix similarMixes] firstObject] objectForKey:@"tagList"]);
        
        XCTAssertNotNil([[[mix similarMixes] lastObject] objectForKey:@"_id"]);
        XCTAssertNotNil([[[mix similarMixes] lastObject] objectForKey:@"name"]);
        XCTAssertNotNil([[[mix similarMixes] lastObject] objectForKey:@"tagList"]);
        
        return @"OK";
    }, nil);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Test Error: %@", [error localizedDescription]);
        }
    }];
}

- (void)testGetTracksAlreadyPlayed
{
    CSTBaseMix *mix = [CSTBaseMix new];
    [mix set_id:@"14"];
    
    RXPromise *p = [_contr getTracksAlreadyPlayed:mix];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should get tracks already played for mix"];
    
    p.then(^id (id o) {
        [expectation fulfill];
        
        XCTAssertNotNil([mix tracksPlayed]);
        XCTAssertGreaterThanOrEqual([[mix tracksPlayed] count], 0);

        if ([[mix tracksPlayed] count] > 0) {
            
            XCTAssertNotNil([[[mix tracksPlayed] firstObject] objectForKey:@"_id"]);
            XCTAssertNotNil([[[mix tracksPlayed] firstObject] objectForKey:@"name"]);
            XCTAssertNotNil([[[mix tracksPlayed] firstObject] objectForKey:@"performer"]);
            
            XCTAssertNotNil([[[mix tracksPlayed] lastObject] objectForKey:@"_id"]);
            XCTAssertNotNil([[[mix tracksPlayed] lastObject] objectForKey:@"name"]);
            XCTAssertNotNil([[[mix tracksPlayed] lastObject] objectForKey:@"performer"]);
        }
        
        return @"OK";
    }, nil);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Test Error: %@", [error localizedDescription]);
        }
    }];
}

@end
