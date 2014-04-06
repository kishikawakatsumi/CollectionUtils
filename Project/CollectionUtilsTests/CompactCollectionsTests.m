//
//  CompactCollectionsTests.m
//  CollectionUtils
//
//  Created by kishikawa katsumi on 2014/04/06.
//  Copyright (c) 2014 kishikawa katsumi. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Compact.h"

@interface CompactCollectionsTests : XCTestCase

@end

@implementation CompactCollectionsTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

#pragma mark -

- (void)testNestedDictionaryInArray
{
    NSArray *array = @[@"0",
                       @"1",
                       [NSNull null],
                       @"2",
                       @{@"zero": @"0",
                         @"one": @"1",
                         @"null": [NSNull null],
                         @"two": @"2"},
                       @"4"];
    NSArray *compactArray = [array cu_compactArray];
    
    XCTAssertEqual(compactArray.count, (NSUInteger)5);
    XCTAssertEqual([compactArray[3] count], (NSUInteger)3);
}

- (void)testNestedDictionaryInMutableArray
{
    NSArray *array = @[@"0",
                       @"1",
                       [NSNull null],
                       @"2",
                       @{@"zero": @"0",
                         @"one": @"1",
                         @"null": [NSNull null],
                         @"two": @"2"},
                       @"4"];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqual(compactArray.count, (NSUInteger)5);
    XCTAssertEqual([compactArray[3] count], (NSUInteger)3);
}

#pragma mark -

- (void)testNestedArrayInDictionary
{
    NSDictionary *dictionary = @{@"zero": @"0",
                                 @"one": @[@"0",
                                           @"1",
                                           [NSNull null],
                                           @"2",
                                           @"4"],
                                 @"null": [NSNull null],
                                 @"two": @"2"};
    NSDictionary *compactDictionary = [dictionary cu_compactDictionary];
    
    XCTAssertEqual(compactDictionary.count, (NSUInteger)3);
    XCTAssertEqual([compactDictionary[@"one"] count], (NSUInteger)4);
}

- (void)testNestedArrayInMutableDictionary
{
    NSDictionary *dictionary = @{@"zero": @"0",
                                 @"one": @[@"0",
                                           @"1",
                                           [NSNull null],
                                           @"2",
                                           @"4"],
                                 @"null": [NSNull null],
                                 @"two": @"2"};
    NSMutableDictionary *compactDictionary = [[dictionary cu_compactDictionary] mutableCopy];
    
    XCTAssertEqual(compactDictionary.count, (NSUInteger)3);
    XCTAssertEqual([compactDictionary[@"one"] count], (NSUInteger)4);
}

@end
