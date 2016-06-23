//
//  TagsExplorerControllerTest.m
//  Cassette
//
//  Created by Stephen Hatton on 23/06/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CSTTagsExplorerController.h"
#import "ViewController.h"

@interface TagsExplorerControllerTest : XCTestCase
@property (nonatomic, retain) ViewController *vc;
@property (nonatomic, retain) CSTTagsExplorerController *contr;
@end

@implementation TagsExplorerControllerTest

- (void)setUp
{
    [super setUp];
    _vc = [ViewController new];
    _contr = [CSTTagsExplorerController new];
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

- (void)testGetTopTags
{
    XCTAssertFalse([[_contr searchSetup] previousPage]);
    XCTAssertFalse([[_contr searchSetup] nextPage]);
    XCTAssertNotNil([_contr searchSetup]);
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should get top tags"];
    
    RXPromise *p = [_vc setupApplication];
    
    p.then(^id (id o) {
        return [_contr getTopTags];
    }, nil)
    
    .then(^id (id o) {
        [expectation fulfill];
        
        XCTAssertNotNil([_contr tagsSearchSetup]);
        XCTAssertNotNil([[[_contr tagsSearchSetup] firstObject] valueForKey:@"name"]);
        XCTAssertNotNil([[[_contr tagsSearchSetup] lastObject] valueForKey:@"name"]);
        
        XCTAssertGreaterThanOrEqual([[_contr searchSetup] numberOfResults], 1);
        
        XCTAssertTrue([[_contr searchSetup] nextPage]);
        
        return @"OK";
    }, nil);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Test Error: %@", [error localizedDescription]);
        }
    }];
}

- (void)testGetAutocompleteTags
{
    XCTAssertNil([_contr autocompleteTags]);
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should get autocomplete tags"];
    
    RXPromise *p = [_vc setupApplication];
    
    p.then(^id (id o) {
        return [_contr getAutocompleteTags:@"rock"];
    }, nil)
    
    .then(^id (id o) {
        [expectation fulfill];
        
        XCTAssertNotNil([_contr autocompleteTags]);
        XCTAssertNotNil([[[_contr autocompleteTags] firstObject] valueForKey:@"name"]);
        XCTAssertNotNil([[[_contr autocompleteTags] lastObject] valueForKey:@"name"]);
        
        XCTAssertGreaterThanOrEqual([[_contr autocompleteTags] count], 1);
        
        return @"OK";
    }, nil);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Test Error: %@", [error localizedDescription]);
        }
    }];
}

- (void)testTagAddingAndRemoving
{
    XCTAssertNil([_contr selectedTags]);
    
    CSTTag *tag = [CSTTag new];
    [tag setName:@"rock"];
    
    [_contr addSelectedTag:tag];
    
    XCTAssertEqual([[_contr selectedTags] count], 1);
    
    [_contr addSelectedTag:tag];
    [_contr addSelectedTag:tag];
    [_contr addSelectedTag:tag];
    [_contr addSelectedTag:tag];
    
    XCTAssertEqual([[_contr selectedTags] count], 3);
    
    [_contr removeSelectedTag:0];
}

- (void)testGetMixesFromTags
{
    XCTAssertNotNil([_contr mixesSearchSetup]);
    XCTAssertFalse([[_contr mixesSearchSetup] previousPage]);
    XCTAssertFalse([[_contr mixesSearchSetup] nextPage]);
    
    CSTTag *tag = [CSTTag new];
    [tag setName:@"rock"];
    [_contr addSelectedTag:tag];
    
    XCTAssertNil([_contr selectedTagsMixes]);
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should get mixes from tags"];
    
    RXPromise *p = [_vc setupApplication];
    
    p.then(^id (id o) {
        return [_contr getMixesFromTagSelection];
    }, nil)
    
    .then(^id (id o) {
        [expectation fulfill];
        
        XCTAssertNotNil([_contr selectedTagsMixes]);
        
        XCTAssertGreaterThanOrEqual([[_contr selectedTagsMixes] count], 1);
        
        XCTAssertNotNil([[[_contr selectedTagsMixes] firstObject] valueForKey:@"_id"]);
        XCTAssertNotNil([[[_contr selectedTagsMixes] firstObject] valueForKey:@"name"]);
        XCTAssertNotNil([[[_contr selectedTagsMixes] firstObject] valueForKey:@"tagList"]);
        
        XCTAssertNotNil([[[_contr selectedTagsMixes] lastObject] valueForKey:@"_id"]);
        XCTAssertNotNil([[[_contr selectedTagsMixes] lastObject] valueForKey:@"name"]);
        XCTAssertNotNil([[[_contr selectedTagsMixes] lastObject] valueForKey:@"tagList"]);
        
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
