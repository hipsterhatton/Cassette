//
//  testy.m
//  Cassette
//
//  Created by Stephen Hatton on 16/06/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CSTMixController.h"

@interface testy : XCTestCase
@property(nonatomic, retain) CSTMixController *controller;
@end

@implementation testy

- (void)setUp {
    [super setUp];
    _controller = [CSTMixController new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    int a = 9;
    int b = 9;
    XCTAssertEqual(a, b);
}

@end
