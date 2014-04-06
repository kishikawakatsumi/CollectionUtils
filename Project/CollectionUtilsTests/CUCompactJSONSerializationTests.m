//
//  CUJSONSerializationTests.m
//  CollectionUtils
//
//  Created by kishikawa katsumi on 2014/04/07.
//  Copyright (c) 2014 kishikawa katsumi. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Compact.h"
#import "CUJSONSerialization.h"

@interface CUJSONSerializationTests : XCTestCase

@end

@implementation CUJSONSerializationTests

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
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:kNilOptions error:nil];
    
    id object = [CUJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    XCTAssertEqual([object count], 5);
    XCTAssertEqual([object[3] count], 3);
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
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:nil];
    
    id object = [CUJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    XCTAssertEqual([object count], 3);
    XCTAssertEqual([object[@"one"] count], 4);
}

@end
