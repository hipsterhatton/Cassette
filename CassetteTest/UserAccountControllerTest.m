//
//  UserAccountControllerTest.m
//  Cassette
//
//  Created by Stephen Hatton on 24/06/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"
#import "CSTUserAccountController.h"

@interface UserAccountControllerTest : XCTestCase
@property(nonatomic, retain) CSTUserAccountController *contr;
@property(nonatomic, retain) ViewController *vc;
@end

@implementation UserAccountControllerTest

- (void)setUp
{
    [super setUp];
    _vc = [ViewController new];
    _contr = [CSTUserAccountController new];
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

- (void)testLogUserIn
{
    XCTAssertNil([_contr appUser]);
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should log user in"];
    
    RXPromise *p = [_vc setupApplication];
    
    p.then(^id (id o) {
        return [_contr logUserIn:@"HipsterHatton" :@"newspaper1"];
    }, nil)
    
    .then(^id (id o) {
        [expectation fulfill];
        
        XCTAssertNotNil([[_contr appUser] _id]);
        XCTAssertNotNil([[_contr appUser] name]);
        XCTAssertTrue([[_contr appUser] loggedIn]);
        
        return @"OK";
    }, nil);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Test Error: %@", [error localizedDescription]);
        }
    }];
}

@end
