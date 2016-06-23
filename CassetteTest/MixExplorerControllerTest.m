//
//  MixExplorerControllerTest.m
//  Cassette
//
//  Created by Stephen Hatton on 22/06/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CSTMixExplorerController.h"
#import "ViewController.h"

@interface MixExplorerControllerTest : XCTestCase
@property (nonatomic, retain) CSTMixExplorerController *contr;
@property (nonatomic, retain) ViewController *vc;
@end

@implementation MixExplorerControllerTest

- (void)setUp
{
    [super setUp];
    _vc = [ViewController new];
    _contr = [CSTMixExplorerController new];
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

- (void)testGetHomepageMixes
{
    XCTAssertFalse([[_contr mixesSearchSetup] previousPage]);
    XCTAssertFalse([[_contr mixesSearchSetup] nextPage]);
    XCTAssertNotNil([_contr mixesSearchSetup]);
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should get homepage mixes"];
    
    RXPromise *p = [_vc setupApplication];
    
    p.then(^id (id o) {
        return [_contr getHomepageMixes];
    }, nil)
    
    .then(^id (id o) {
        
        [expectation fulfill];
        
        XCTAssertNotNil([_contr homepageMixes]);
        
        XCTAssertGreaterThanOrEqual([[_contr homepageMixes] count], 1);
        
        XCTAssertNotNil([[[_contr homepageMixes] firstObject] valueForKey:@"_id"]);
        XCTAssertNotNil([[[_contr homepageMixes] firstObject] valueForKey:@"name"]);
        XCTAssertNotNil([[[_contr homepageMixes] firstObject] valueForKey:@"tagList"]);
        
        XCTAssertNotNil([[[_contr homepageMixes] lastObject] valueForKey:@"_id"]);
        XCTAssertNotNil([[[_contr homepageMixes] lastObject] valueForKey:@"name"]);
        XCTAssertNotNil([[[_contr homepageMixes] lastObject] valueForKey:@"tagList"]);
        
        XCTAssertTrue([[_contr mixesSearchSetup] nextPage]);
        
        return @"OK";
    }, nil);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Test Error: %@", [error localizedDescription]);
        }
    }];
}

@end
