//
//  CUCompactDictionaryTests.m
//  CollectionUtils
//
//  Created by kishikawa katsumi on 2014/04/06.
//  Copyright (c) 2014 kishikawa katsumi. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Compact.h"

@interface CUCompactDictionaryTests : XCTestCase

@end

@implementation CUCompactDictionaryTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

#pragma mark - utility methods

- (NSDictionary *)sampleDictionary
{
    NSDictionary *dictionary = @{@"one": @"1",
                                 @"null": [NSNull null],
                                 @"two": @"2",
                                 @"three": @"3"};
    return dictionary;
}

#pragma mark - test cases

#pragma mark - initializers

- (void)testDictionary
{
    NSDictionary *dictionary = [self sampleDictionary];
    NSDictionary *compactDictionary = [dictionary cu_compactDictionary];
    
    XCTAssertEqual(compactDictionary.count, 3);
    XCTAssertEqualObjects(compactDictionary[@"one"], @"1");
    XCTAssertEqualObjects(compactDictionary[@"two"], @"2");
    XCTAssertEqualObjects(compactDictionary[@"three"], @"3");
}

- (void)testNestedDictionary
{
    NSDictionary *dictionary = @{@"one": @"1",
                                 @"null": [NSNull null],
                                 @"two": @{@"one": @"1",
                                           @"null": [NSNull null],
                                           @"two": @"2",
                                           @"three": @"3"},
                                 @"three": @"3" };
    NSDictionary *compactDictionary = [dictionary cu_compactDictionary];
    
    XCTAssertEqual(compactDictionary.count, 3);
    XCTAssertEqual([compactDictionary[@"two"] count], 3);
}

#pragma mark - primitive instance methods

- (void)testCount
{
    NSDictionary *dictionary = [self sampleDictionary];
    NSDictionary *compactDictionary = [dictionary cu_compactDictionary];
    
    XCTAssertEqual(compactDictionary.count, 3);
}

- (void)testObjectForKey
{
    NSDictionary *dictionary = [self sampleDictionary];
    NSDictionary *compactDictionary = [dictionary cu_compactDictionary];
    
    XCTAssertEqualObjects([compactDictionary objectForKey:@"one"], @"1");
    XCTAssertEqualObjects([compactDictionary objectForKey:@"two"], @"2");
    XCTAssertEqualObjects([compactDictionary objectForKey:@"three"], @"3");
}

- (void)testKeyEnumerator
{
    NSDictionary *dictionary = [self sampleDictionary];
    NSDictionary *compactDictionary = [dictionary cu_compactDictionary];
    
    NSEnumerator *enumerator = compactDictionary.keyEnumerator;
    id object = nil;
    while ((object = enumerator.nextObject)) {
        if ([object isEqualToString:@"one"]) {
            XCTAssertEqualObjects(compactDictionary[object], @"1");
        }
        if ([object isEqualToString:@"two"]) {
            XCTAssertEqualObjects(compactDictionary[object], @"2");
        }
        if ([object isEqualToString:@"null"]) {
            XCTFail(@"Should not reach here.");
        }
        if ([object isEqualToString:@"three"]) {
            XCTAssertEqualObjects(compactDictionary[object], @"3");
        }
    }
}

#pragma mark -

- (void)testAllKeys
{
    NSDictionary *dictionary = [self sampleDictionary];
    NSDictionary *compactDictionary = [dictionary cu_compactDictionary];
    
    NSArray *allKeys = compactDictionary.allKeys;
    NSArray *sorted = [allKeys sortedArrayUsingSelector:@selector(compare:)];
    
    XCTAssertEqualObjects(sorted, (@[@"one", @"three", @"two"]));
}

- (void)testAllKeysForObject
{
    NSDictionary *dictionary = @{@"one": @"1",
                                 @"two": @"2",
                                 @"null": [NSNull null],
                                 @"three": @"1"};
    NSDictionary *compactDictionary = [dictionary cu_compactDictionary];
    
    NSArray *allKeys = [compactDictionary allKeysForObject:@"1"];
    NSArray *sorted = [allKeys sortedArrayUsingSelector:@selector(compare:)];
    
    XCTAssertEqualObjects(sorted, (@[@"one", @"three"]));
}

- (void)testAllValues
{
    NSDictionary *dictionary = [self sampleDictionary];
    NSDictionary *compactDictionary = [dictionary cu_compactDictionary];
    
    NSArray *allValues = compactDictionary.allValues;
    NSArray *sorted = [allValues sortedArrayUsingSelector:@selector(compare:)];
    
    XCTAssertEqualObjects(sorted, (@[@"1", @"2", @"3"]));
}

- (void)testIsEqualToDictionary
{
    NSDictionary *dictionary = @{@"one": @"1",
                                 @"two": @"2",
                                 @"null": [NSNull null],
                                 @"three": @"3"};
    NSDictionary *expected = @{@"one": @"1",
                               @"two": @"2",
                               @"three": @"3"};
    NSDictionary *compactDictionary = [dictionary cu_compactDictionary];
    
    XCTAssertTrue([compactDictionary isEqualToDictionary:expected]);
    XCTAssertTrue([compactDictionary isEqualToDictionary:dictionary]);
}

- (void)testObjectEnumerator
{
    NSDictionary *dictionary = [self sampleDictionary];
    NSDictionary *compactDictionary = [dictionary cu_compactDictionary];
    
    NSEnumerator *enumerator = compactDictionary.objectEnumerator;
    id object = nil;
    while ((object = enumerator.nextObject)) {
        if ([object isEqualToString:@"one"]) {
            XCTAssertEqualObjects(compactDictionary[object], @"1");
        }
        if ([object isEqualToString:@"two"]) {
            XCTAssertEqualObjects(compactDictionary[object], @"2");
        }
        if ([object isEqualToString:@"null"]) {
            XCTFail(@"Should not reach here.");
        }
        if ([object isEqualToString:@"three"]) {
            XCTAssertEqualObjects(compactDictionary[object], @"3");
        }
    }
}

- (void)testOjectsForKeysNotFoundMarker
{
    NSDictionary *dictionary = [self sampleDictionary];
    NSDictionary *compactDictionary = [dictionary cu_compactDictionary];
    
    id marker = [[NSObject alloc] init];
    NSArray *objects = [compactDictionary objectsForKeys:@[@"one", @"null", @"two", @"four"] notFoundMarker:marker];
    
    XCTAssertEqualObjects(objects[0], @"1");
    XCTAssertEqualObjects(objects[1], marker);
    XCTAssertEqualObjects(objects[2], @"2");
    XCTAssertEqualObjects(objects[3], marker);
}

- (void)testWriteToFile
{
    NSDictionary *dictionary = [self sampleDictionary];
    NSDictionary *compactDictionary = [dictionary cu_compactDictionary];
    
    NSString *temporaryDirectory = NSTemporaryDirectory();
    NSString *path = [temporaryDirectory stringByAppendingPathComponent:@"dictionary.temp"];
    
    XCTAssertFalse([dictionary writeToFile:path atomically:YES]);
    XCTAssertTrue([compactDictionary writeToURL:[NSURL fileURLWithPath:path] atomically:YES]);
}

- (void)testKeysSortedByValueUsingSelector
{
    NSDictionary *dictionary = [self sampleDictionary];
    NSDictionary *compactDictionary = [dictionary cu_compactDictionary];
    
    NSArray *sorted = [compactDictionary keysSortedByValueUsingSelector:@selector(compare:)];
    
    XCTAssertEqualObjects(sorted, (@[@"one", @"two", @"three"]));
}

- (void)testGetObjectsAndKeys
{
    NSDictionary *dictionary = [self sampleDictionary];
    NSDictionary *compactDictionary = [dictionary cu_compactDictionary];
    
    id __unsafe_unretained keys[3];
    id __unsafe_unretained objects[3];
    [compactDictionary getObjects:objects andKeys:keys];
    
    XCTAssertEqualObjects(compactDictionary[keys[0]], objects[0]);
    XCTAssertEqualObjects(compactDictionary[keys[1]], objects[1]);
    XCTAssertEqualObjects(compactDictionary[keys[2]], objects[2]);
}

- (void)testObjectForKeyedSubscript
{
    NSDictionary *dictionary = [self sampleDictionary];
    NSDictionary *compactDictionary = [dictionary cu_compactDictionary];
    
    XCTAssertEqualObjects(compactDictionary[@"one"], @"1");
    XCTAssertEqualObjects(compactDictionary[@"two"], @"2");
    XCTAssertEqualObjects(compactDictionary[@"three"], @"3");
}

- (void)testEnumerateKeysAndObjectsUsingBlock
{
    NSDictionary *dictionary = [self sampleDictionary];
    NSDictionary *compactDictionary = [dictionary cu_compactDictionary];
    
    [compactDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isEqualToString:@"one"]) {
            XCTAssertEqualObjects(compactDictionary[obj], @"1");
        }
        if ([obj isEqualToString:@"two"]) {
            XCTAssertEqualObjects(compactDictionary[obj], @"2");
        }
        if ([obj isEqualToString:@"null"]) {
            XCTFail(@"Should not reach here.");
        }
        if ([obj isEqualToString:@"three"]) {
            XCTAssertEqualObjects(compactDictionary[obj], @"3");
        }
    }];
}

- (void)testEnumerateKeysAndObjectsWithOptionsUsingBlock
{
    NSDictionary *dictionary = [self sampleDictionary];
    NSDictionary *compactDictionary = [dictionary cu_compactDictionary];
    
    [compactDictionary enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent | NSEnumerationReverse usingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isEqualToString:@"one"]) {
            XCTAssertEqualObjects(compactDictionary[obj], @"1");
        }
        if ([obj isEqualToString:@"two"]) {
            XCTAssertEqualObjects(compactDictionary[obj], @"2");
        }
        if ([obj isEqualToString:@"null"]) {
            XCTFail(@"Should not reach here.");
        }
        if ([obj isEqualToString:@"three"]) {
            XCTAssertEqualObjects(compactDictionary[obj], @"3");
        }
    }];
}

- (void)testKeysSortedByValueUsingComparator
{
    NSDictionary *dictionary = [self sampleDictionary];
    NSDictionary *compactDictionary = [dictionary cu_compactDictionary];
    
    NSArray *keysSortedByValue = [compactDictionary keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *str1 = obj1;
        NSString *str2 = obj2;
        return [str1 compare:str2];
    }];
    
    XCTAssertEqualObjects(keysSortedByValue[0], @"one");
    XCTAssertEqualObjects(keysSortedByValue[1], @"two");
    XCTAssertEqualObjects(keysSortedByValue[2], @"three");
}

- (void)testKeysSortedByValueWithOptionsUsingComparator
{
    NSDictionary *dictionary = [self sampleDictionary];
    NSDictionary *compactDictionary = [dictionary cu_compactDictionary];
    
    NSArray *keysSortedByValue = [compactDictionary keysSortedByValueWithOptions:NSEnumerationConcurrent | NSEnumerationReverse usingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *str1 = obj1;
        NSString *str2 = obj2;
        return [str1 compare:str2];
    }];
    
    XCTAssertEqualObjects(keysSortedByValue[0], @"one");
    XCTAssertEqualObjects(keysSortedByValue[1], @"two");
    XCTAssertEqualObjects(keysSortedByValue[2], @"three");
}

- (void)testKeysOfEntriesPassingTest
{
    NSDictionary *dictionary = [self sampleDictionary];
    NSDictionary *compactDictionary = [dictionary cu_compactDictionary];
    
    NSSet *keysOfEntries = [compactDictionary keysOfEntriesPassingTest:^BOOL(id key, id obj, BOOL *stop) {
        return [obj isEqual:@"2"] ||  [obj isEqual:@"3"];
    }];
    
    XCTAssertEqualObjects(keysOfEntries, ([NSSet setWithObjects:@"two", @"three", nil]));
}

- (void)testKeysOfEntriesWithOptionsPassingTest
{
    NSDictionary *dictionary = [self sampleDictionary];
    NSDictionary *compactDictionary = [dictionary cu_compactDictionary];
    
    NSSet *keysOfEntries = [compactDictionary keysOfEntriesWithOptions:NSEnumerationConcurrent | NSEnumerationReverse passingTest:^BOOL(id key, id obj, BOOL *stop) {
        return [obj isEqual:@"2"] ||  [obj isEqual:@"3"];
    }];
    
    XCTAssertEqualObjects(keysOfEntries, ([NSSet setWithObjects:@"two", @"three", nil]));
}

@end
