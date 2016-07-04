//
//  SearchingControllerTest.m
//  Cassette
//
//  Created by Stephen Hatton on 23/06/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"
#import "CSTSearchingController.h"

@interface SearchingControllerTest : XCTestCase
@property(nonatomic, retain) ViewController *vc;
@property(nonatomic, retain) CSTSearchingController *contr;
@end

@implementation SearchingControllerTest

- (void)setUp
{
    [super setUp];
    _vc = [ViewController new];
    _contr = [CSTSearchingController new];
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

- (void)testAutocompleteSearch
{
    XCTAssertNil([_contr mixes]);
    XCTAssertNil([_contr users]);
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should autcomplete search"];
    
    RXPromise *p = [_vc setupApplication];
    
    p.then(^id (id o) {
        return [_contr autocompleteSearch:@"rock"];
    }, nil)
    
    .then(^id (id o) {
        [expectation fulfill];
        
        XCTAssertNotNil([_contr mixes]);
        XCTAssertNotNil([_contr users]);
        
        XCTAssertNotNil([[[_contr mixes] firstObject] valueForKey:@"_id"]);
        XCTAssertNotNil([[[_contr mixes] firstObject] valueForKey:@"name"]);
        XCTAssertNotNil([[[_contr mixes] firstObject] valueForKey:@"tagList"]);
        
        XCTAssertNotNil([[[_contr users] firstObject] valueForKey:@"_id"]);
        XCTAssertNotNil([[[_contr users] firstObject] valueForKey:@"name"]);
        XCTAssertNotNil([[[_contr users] firstObject] valueForKey:@"avatar"]);
        
        return @"OK";
    }, nil);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Test Error: %@", [error localizedDescription]);
        }
    }];
}

@end
