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

- (void)setUp {
    [super setUp];
    _vc = [ViewController new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    RXPromise *p = [_vc setupApplication];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"View Controller should play token"];
    
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

@end
