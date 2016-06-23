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

- (void)setUp
{
    [super setUp];
    _vc = [ViewController new];
    _contr = [CSTMixController new];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    _vc = nil;
    _contr = nil;
    [super tearDown];
}

- (void)testInit
{
    XCTAssertNotNil(_contr.api);
    XCTAssertNotNil(_contr.shuttle);
}

- (void)testGetMixDetails
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should get mix details"];
    
    RXPromise *p = [_vc setupApplication];
    
    p.then(^id (id o) {
        return [_contr getMixDetails:@"14"];
    }, nil)
    
    .then(^id (id o) {
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
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should get similar mixes"];
     
    RXPromise *p = [_vc setupApplication];
    
    p.then(^id (id o) {
        return [_contr getSimilarMixes:mix];
    }, nil)
    
    .then(^id (id o) {
        
        XCTAssertNotNil([mix similarMixes]);
        XCTAssertGreaterThanOrEqual([[mix similarMixes] count], 1);
        
        XCTAssertNotNil([[[mix similarMixes] firstObject] valueForKey:@"_id"]);
        XCTAssertNotNil([[[mix similarMixes] firstObject] valueForKey:@"name"]);
        XCTAssertNotNil([[[mix similarMixes] firstObject] valueForKey:@"tagList"]);
        
        XCTAssertNotNil([[[mix similarMixes] lastObject] valueForKey:@"_id"]);
        XCTAssertNotNil([[[mix similarMixes] lastObject] valueForKey:@"name"]);
        XCTAssertNotNil([[[mix similarMixes] lastObject] valueForKey:@"tagList"]);
        
        [expectation fulfill];
        
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
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should get tracks already played for mix"];
    
    RXPromise *p = [_vc setupApplication];
    
    p.then(^id (id o) {
        return [_contr getTracksAlreadyPlayed:mix];
    }, nil)
    
    .then(^id (id o) {
        [expectation fulfill];
        
        XCTAssertNotNil([mix tracksPlayed]);
        XCTAssertGreaterThanOrEqual([[mix tracksPlayed] count], 0);

        if ([[mix tracksPlayed] count] > 0) {
            
            XCTAssertNotNil([[[mix tracksPlayed] firstObject] valueForKey:@"_id"]);
            XCTAssertNotNil([[[mix tracksPlayed] firstObject] valueForKey:@"name"]);
            XCTAssertNotNil([[[mix tracksPlayed] firstObject] valueForKey:@"performer"]);
            
            XCTAssertNotNil([[[mix tracksPlayed] lastObject] valueForKey:@"_id"]);
            XCTAssertNotNil([[[mix tracksPlayed] lastObject] valueForKey:@"name"]);
            XCTAssertNotNil([[[mix tracksPlayed] lastObject] valueForKey:@"performer"]);
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
