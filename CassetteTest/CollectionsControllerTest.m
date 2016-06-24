//
//  CollectionsControllerTest.m
//  Cassette
//
//  Created by Stephen Hatton on 23/06/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"
#import "CSTCollectionsController.h"

@interface CollectionsControllerTest : XCTestCase
@property (nonatomic, retain) CSTCollectionsController *contr;
@property (nonatomic, retain) ViewController *vc;
@end

@implementation CollectionsControllerTest

- (void)setUp
{
    [super setUp];
    _vc = [ViewController new];
    _contr = [CSTCollectionsController new];
    [_vc setupApplication];
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

- (void)testGetCollection
{
    CSTUser *user = [CSTUser new];
    [user set_id:@"1"];
    
    XCTAssertNil([_contr collections]);
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should get collections"];
    
    RXPromise *p = [_vc setupApplication];
    
    p.then(^id (id o) {
        return [_contr getCollections:user];
    }, nil)
    
    .then(^id (id o) {
        [expectation fulfill];
        
        XCTAssertNotNil([_contr collections]);
        
        XCTAssertGreaterThanOrEqual([[_contr collections] count], 1);
        XCTAssertGreaterThanOrEqual([[[[_contr collections] firstObject] mixes] count], 1);
        
        XCTAssertNotNil([[[_contr collections] firstObject] valueForKey:@"_id"]);
        XCTAssertNotNil([[[_contr collections] firstObject] valueForKey:@"name"]);
        XCTAssertNotNil([[[_contr collections] firstObject] valueForKey:@"_description"]);
        
        XCTAssertNotNil([[[[[_contr collections] firstObject] mixes] firstObject] valueForKey:@"_id"]);
        XCTAssertNotNil([[[[[_contr collections] firstObject] mixes] firstObject] valueForKey:@"name"]);
        XCTAssertNotNil([[[[[_contr collections] firstObject] mixes] firstObject] valueForKey:@"tagList"]);
        
        XCTAssertNotNil([[[[[_contr collections] firstObject] mixes] lastObject] valueForKey:@"_id"]);
        XCTAssertNotNil([[[[[_contr collections] firstObject] mixes] lastObject] valueForKey:@"name"]);
        XCTAssertNotNil([[[[[_contr collections] firstObject] mixes] lastObject] valueForKey:@"tagList"]);
        
        return @"OK";
    }, nil);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Test Error: %@", [error localizedDescription]);
        }
    }];
}

- (void)testGetEditableCollections
{
    CSTUser *user = [CSTUser new];
    [user set_id:@"1"];
    
    XCTAssertNil([_contr collections]);
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should get edit collections"];
    
    RXPromise *p = [_vc setupApplication];
    
    p.then(^id (id o) {
        return [_contr getEditableCollections:user];
    }, nil)
    
    .then(^id (id o) {
        [expectation fulfill];
        
//        XCTAssertNotNil([_contr collections]);
//        
//        XCTAssertGreaterThanOrEqual([[_contr collections] count], 1);
//        XCTAssertGreaterThanOrEqual([[[[_contr collections] firstObject] mixes] count], 1);
//        
//        XCTAssertNotNil([[[_contr collections] firstObject] valueForKey:@"_id"]);
//        XCTAssertNotNil([[[_contr collections] firstObject] valueForKey:@"name"]);
//        XCTAssertNotNil([[[_contr collections] firstObject] valueForKey:@"_description"]);
//        
//        XCTAssertNotNil([[[[[_contr collections] firstObject] mixes] firstObject] valueForKey:@"_id"]);
//        XCTAssertNotNil([[[[[_contr collections] firstObject] mixes] firstObject] valueForKey:@"name"]);
//        XCTAssertNotNil([[[[[_contr collections] firstObject] mixes] firstObject] valueForKey:@"tagList"]);
//        XCTAssertNotNil([[[[[_contr collections] firstObject] mixes] firstObject] valueForKey:@"editable"]);
//        
//        XCTAssertNotNil([[[[[_contr collections] firstObject] mixes] lastObject] valueForKey:@"_id"]);
//        XCTAssertNotNil([[[[[_contr collections] firstObject] mixes] lastObject] valueForKey:@"name"]);
//        XCTAssertNotNil([[[[[_contr collections] firstObject] mixes] lastObject] valueForKey:@"tagList"]);
//        XCTAssertNotNil([[[[[_contr collections] firstObject] mixes] lastObject] valueForKey:@"editable"]);
//        
//        XCTAssertNotNil([_contr listenLaterCollection]);
//        XCTAssertNotNil([[_contr listenLaterCollection] valueForKey:@"_id"]);
//        XCTAssertNotNil([[_contr listenLaterCollection] valueForKey:@"name"]);
//        XCTAssertNotNil([[_contr listenLaterCollection] valueForKey:@"tagList"]);
        
        return @"OK";
    }, nil);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Test Error: %@", [error localizedDescription]);
        }
    }];
}

@end
