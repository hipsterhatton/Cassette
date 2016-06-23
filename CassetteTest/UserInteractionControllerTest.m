//
//  UserInteractionControllerTest.m
//  Cassette
//
//  Created by Stephen Hatton on 23/06/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"
#import "CSTUsersController.h"

@interface UserInteractionControllerTest : XCTestCase
@property(nonatomic, retain) ViewController *vc;
@property(nonatomic, retain) CSTUsersController *contr;
@end

@implementation UserInteractionControllerTest

- (void)setUp
{
    [super setUp];
    _vc = [ViewController new];
    _contr = [CSTUsersController new];
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

- (void)testGetUserDetails
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should get user details"];
    
    XCTAssertNil([_contr user]);
    
    RXPromise *p = [_vc setupApplication];
    
    p.then(^id (id o) {
        return [_contr getUserDetails:@"1"];
    }, nil)
    
    .then(^id (id o) {
        [expectation fulfill];
        
        XCTAssertNotNil([_contr user]);
        
        XCTAssertNotNil([[_contr user] valueForKey:@"_id"]);
        XCTAssertNotNil([[_contr user] valueForKey:@"name"]);
        XCTAssertNotNil([[_contr user] valueForKey:@"avatar"]);
        
        XCTAssertNotNil([[_contr user] followers]);
        XCTAssertNotNil([[_contr user] following]);
        XCTAssertNotNil([[_contr user] collections]);

        XCTAssertGreaterThanOrEqual([[[_contr user] followers] count], 1);
        XCTAssertGreaterThanOrEqual([[[_contr user] following] count], 1);
        XCTAssertGreaterThanOrEqual([[[_contr user] collections] count], 1);
        
        return @"OK";
    }, nil);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Test Error: %@", [error localizedDescription]);
        }
    }];
}

- (void)testGetUserMixes
{
    CSTUser *user = [CSTUser new];
    [user set_id:@"1"];
    
    XCTAssertNil([user madeMixesSearchSetup]);
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should get user mixes"];
    
    RXPromise *p = [_vc setupApplication];
    
    p.then(^id (id o) {
        return [_contr getUserMixes:user];
    }, nil)
    
    .then(^id (id o) {
        [expectation fulfill];
        
        XCTAssertGreaterThanOrEqual([[user madeMixes] count], 1);
        XCTAssertNotNil([user madeMixesSearchSetup]);
        
        return @"OK";
    }, nil);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Test Error: %@", [error localizedDescription]);
        }
    }];
}

- (void)testGetUserLikedMixes
{
    CSTUser *user = [CSTUser new];
    [user set_id:@"1"];
    
    XCTAssertNil([user likedMixesSearchSetup]);
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should get user liked mixes"];
    
    RXPromise *p = [_vc setupApplication];
    
    p.then(^id (id o) {
        return [_contr getLikedMixes:user];
    }, nil)
    
    .then(^id (id o) {
        [expectation fulfill];
        
        XCTAssertGreaterThanOrEqual([[user likedMixes] count], 1);
        XCTAssertNotNil([user likedMixesSearchSetup]);
        
        return @"OK";
    }, nil);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Test Error: %@", [error localizedDescription]);
        }
    }];
}

- (void)testGetUserLikedTracks
{
    CSTUser *user = [CSTUser new];
    [user set_id:@"1"];
    
    XCTAssertNil([user likedTracksSearchSetup]);
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should get user liked tracks"];
    
    RXPromise *p = [_vc setupApplication];
    
    p.then(^id (id o) {
        return [_contr getLikedTracks:user];
    }, nil)
    
    .then(^id (id o) {
        [expectation fulfill];
        
        XCTAssertGreaterThanOrEqual([[user likedTracks] count], 1);
        XCTAssertNotNil([user likedTracksSearchSetup]);
        
        return @"OK";
    }, nil);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Test Error: %@", [error localizedDescription]);
        }
    }];
}

- (void)testGetUserFollowers
{
    CSTUser *user = [CSTUser new];
    [user set_id:@"1"];
    
    XCTAssertNil([user followersSearchSetup]);
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should get users followers"];
    
    RXPromise *p = [_vc setupApplication];
    
    p.then(^id (id o) {
        return [_contr getUserFollowers:user];
    }, nil)
    
    .then(^id (id o) {
        [expectation fulfill];
        
        XCTAssertGreaterThanOrEqual([[user followers] count], 1);
        XCTAssertNotNil([user followersSearchSetup]);
        
        return @"OK";
    }, nil);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Test Error: %@", [error localizedDescription]);
        }
    }];
}

- (void)testGetUserFollowing
{
    CSTUser *user = [CSTUser new];
    [user set_id:@"1"];
    
    XCTAssertNil([user followingSearchSetup]);
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should get users following"];
    
    RXPromise *p = [_vc setupApplication];
    
    p.then(^id (id o) {
        return [_contr getUserFollowing:user];
    }, nil)
    
    .then(^id (id o) {
        [expectation fulfill];
        
        XCTAssertGreaterThanOrEqual([[user following] count], 1);
        XCTAssertNotNil([user followingSearchSetup]);
        
        return @"OK";
    }, nil);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Test Error: %@", [error localizedDescription]);
        }
    }];
}

@end
