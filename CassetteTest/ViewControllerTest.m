//
//  testy.m
//  Cassette
//
//  Created by Stephen Hatton on 16/06/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface ViewControllerTest : XCTestCase
@property(nonatomic, retain) ViewController *vc;
@end

@implementation ViewControllerTest

- (void)setUp
{
    [super setUp];
    _vc = [ViewController new];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    _vc = nil;
    [super tearDown];
}

- (void)testSetupViewController
{
    XCTAssertNotNil(_vc);
    
    [_vc setupApplication];
    
    XCTAssertNotNil(_vc.api);
    XCTAssertNotNil(_vc.shuttle);
}

- (void)testSetupPlayToken
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"View Controller Set Play Token"];
    
    RXPromise *p = [_vc setupApplication];
    
    p.then(^id (id o) {
        [expectation fulfill];
        return @"OK";
    }, nil)
    
    .then(^id (id o) {
        XCTAssertNotNil(_vc.api.playToken);
        return @"OK";
    }, nil);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Test Error: %@", [error localizedDescription]);
        }
    }];
}

@end
