//
//  CUCompactArrayTests.m
//  CollectionUtils
//
//  Created by kishikawa katsumi on 2014/04/06.
//  Copyright (c) 2014 kishikawa katsumi. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Compact.h"

@interface CUCompactArrayTests : XCTestCase

@end

@implementation CUCompactArrayTests

#pragma mark -

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

#pragma mark - utility methods

- (NSArray *)sampleArray
{
    NSArray *array = @[@"0",
                       @"1",
                       [NSNull null],
                       @"2",
                       [NSNull null],
                       @"3"];
    return array;
}

#pragma mark - test cases

#pragma mark - initializers

- (void)testArray
{
    NSArray *array = [self sampleArray];
    NSArray *compactArray = [array cu_compactArray];
    
    XCTAssertEqual(compactArray.count, (NSUInteger)4);
}

- (void)testNestedArray
{
    NSArray *array = @[@"0",
                       @"1",
                       [NSNull null],
                       @"2",
                       @[@"0",
                         [NSNull null],
                         @"1",
                         [NSNull null],
                         @"2"],
                       @"4"];
    NSArray *compactArray = [array cu_compactArray];
    
    XCTAssertEqual(compactArray.count, (NSUInteger)5);
    XCTAssertEqual([compactArray[3] count], (NSUInteger)3);
}

#pragma mark - primitive instance methods

- (void)testCount
{
    NSArray *array = [self sampleArray];
    NSArray *compactArray = [array cu_compactArray];
    
    XCTAssertEqual(compactArray.count, (NSUInteger)4);
}

- (void)testObjectAtIndex
{
    NSArray *array = [self sampleArray];
    NSArray *compactArray = [array cu_compactArray];
    
    XCTAssertEqualObjects([compactArray objectAtIndex:0], @"0");
    XCTAssertEqualObjects([compactArray objectAtIndex:1], @"1");
    XCTAssertEqualObjects([compactArray objectAtIndex:2], @"2");
    XCTAssertEqualObjects([compactArray objectAtIndex:3], @"3");
}

#pragma mark -

- (void)testArrayByAddingObject
{
    NSArray *array = [self sampleArray];
    NSArray *compactArray = [array cu_compactArray];
    
    compactArray = [compactArray arrayByAddingObject:@"4"];
    compactArray = [compactArray arrayByAddingObject:[NSNull null]];
    compactArray = [compactArray arrayByAddingObject:nil];
    
    XCTAssertEqualObjects([compactArray objectAtIndex:0], @"0");
    XCTAssertEqualObjects([compactArray objectAtIndex:1], @"1");
    XCTAssertEqualObjects([compactArray objectAtIndex:2], @"2");
    XCTAssertEqualObjects([compactArray objectAtIndex:3], @"3");
    XCTAssertEqualObjects([compactArray objectAtIndex:4], @"4");
}

- (void)testArrayByAddingObjectsFromArray
{
    NSArray *array = [self sampleArray];
    NSArray *compactArray = [array cu_compactArray];
    
    compactArray = [compactArray arrayByAddingObjectsFromArray:@[@"4", [NSNull null]]];
    
    XCTAssertEqualObjects([compactArray objectAtIndex:0], @"0");
    XCTAssertEqualObjects([compactArray objectAtIndex:1], @"1");
    XCTAssertEqualObjects([compactArray objectAtIndex:2], @"2");
    XCTAssertEqualObjects([compactArray objectAtIndex:3], @"3");
    XCTAssertEqualObjects([compactArray objectAtIndex:4], @"4");
}

- (void)testComponentsJoinedByString
{
    NSArray *array = [self sampleArray];
    NSArray *compactArray = [array cu_compactArray];
    
    NSString *string = [compactArray componentsJoinedByString:@", "];
    XCTAssertEqualObjects(string, @"0, 1, 2, 3");
}

- (void)testContainsObject
{
    NSArray *array = [self sampleArray];
    NSArray *compactArray = [array cu_compactArray];
    
    XCTAssertTrue([compactArray containsObject:@"0"]);
    XCTAssertTrue([compactArray containsObject:@"1"]);
    XCTAssertTrue([compactArray containsObject:@"2"]);
    XCTAssertTrue([compactArray containsObject:@"3"]);
    
    XCTAssertFalse([compactArray containsObject:@"4"]);
    XCTAssertFalse([compactArray containsObject:[NSNull null]]);
    XCTAssertFalse([compactArray containsObject:nil]);
}

- (void)testFirstObjectCommonWithArray
{
    NSArray *array = @[@"1", @"2", @"3", @"4", [NSNull null], @"5", @"6"];
    NSArray *compactArray = [array cu_compactArray];
    
    XCTAssertEqualObjects([compactArray firstObjectCommonWithArray:@[@"2"]], @"2");
    XCTAssertEqualObjects([compactArray firstObjectCommonWithArray:(@[@"3", @"5"])], @"3");
    XCTAssertEqualObjects([compactArray firstObjectCommonWithArray:(@[@"3", @"5", [NSNull null]])], @"3");
    XCTAssertNil([compactArray firstObjectCommonWithArray:@[@"7"]]);
    XCTAssertNil([compactArray firstObjectCommonWithArray:@[[NSNull null]]]);
    XCTAssertNil([compactArray firstObjectCommonWithArray:(@[@"7", [NSNull null]])]);
}

- (void)testGetObjects
{
    NSArray *array = [self sampleArray];
    NSArray *compactArray = [array cu_compactArray];
    
    id __unsafe_unretained objects[3];
    [compactArray getObjects:objects range:NSMakeRange(1, 3)];
    
    XCTAssertEqualObjects(objects[0], @"1");
    XCTAssertEqualObjects(objects[1], @"2");
    XCTAssertEqualObjects(objects[2], @"3");
}

- (void)testIndexOfObject
{
    NSArray *array = [self sampleArray];
    NSArray *compactArray = [array cu_compactArray];
    
    XCTAssertEqual([compactArray indexOfObject:@"0"], (NSUInteger)0);
    XCTAssertEqual([compactArray indexOfObject:@"1"], (NSUInteger)1);
    XCTAssertEqual([compactArray indexOfObject:@"2"], (NSUInteger)2);
    XCTAssertEqual([compactArray indexOfObject:@"3"], (NSUInteger)3);
    XCTAssertEqual([compactArray indexOfObject:@"4"], (NSUInteger)NSNotFound);
    XCTAssertEqual([compactArray indexOfObject:[NSNull null]], (NSUInteger)NSNotFound);
    XCTAssertEqual([compactArray indexOfObject:nil], (NSUInteger)NSNotFound);
    
    XCTAssertEqual([compactArray indexOfObject:@"0" inRange:NSMakeRange(0, 3)], (NSUInteger)0);
    XCTAssertEqual([compactArray indexOfObject:@"1" inRange:NSMakeRange(0, 3)], (NSUInteger)1);
    XCTAssertEqual([compactArray indexOfObject:@"2" inRange:NSMakeRange(0, 3)], (NSUInteger)2);
    XCTAssertEqual([compactArray indexOfObject:@"3" inRange:NSMakeRange(0, 3)], (NSUInteger)NSNotFound);
}

- (void)testIndexOfObjectIdenticalTo
{
    NSArray *array = [self sampleArray];
    NSArray *compactArray = [array cu_compactArray];
    
    XCTAssertEqual([compactArray indexOfObjectIdenticalTo:@"0"], (NSUInteger)0);
    XCTAssertEqual([compactArray indexOfObjectIdenticalTo:@"1"], (NSUInteger)1);
    XCTAssertEqual([compactArray indexOfObjectIdenticalTo:@"2"], (NSUInteger)2);
    XCTAssertEqual([compactArray indexOfObjectIdenticalTo:@"3"], (NSUInteger)3);
    XCTAssertEqual([compactArray indexOfObjectIdenticalTo:@"4"], (NSUInteger)NSNotFound);
    
    XCTAssertEqual([compactArray indexOfObjectIdenticalTo:@"0" inRange:NSMakeRange(0, 3)], (NSUInteger)0);
    XCTAssertEqual([compactArray indexOfObjectIdenticalTo:@"1" inRange:NSMakeRange(0, 3)], (NSUInteger)1);
    XCTAssertEqual([compactArray indexOfObjectIdenticalTo:@"2" inRange:NSMakeRange(0, 3)], (NSUInteger)2);
    XCTAssertEqual([compactArray indexOfObjectIdenticalTo:@"3" inRange:NSMakeRange(0, 3)], (NSUInteger)NSNotFound);
}

- (void)testIsEqualToArray
{
    NSArray *array = @[@"0", @"1", [NSNull null], @"2", [NSNull null], @"3"];
    NSArray *compactArray = [array cu_compactArray];
    
    XCTAssertTrue([compactArray isEqualToArray:(@[@"0", @"1", @"2", @"3"])]);
    XCTAssertTrue([compactArray isEqualToArray:array]);
}

- (void)testFirstObject
{
    NSArray *array = @[[NSNull null], @"1", [NSNull null], @"2", [NSNull null], @"3"];
    NSArray *compactArray = [array cu_compactArray];
    
    XCTAssertEqualObjects(compactArray.firstObject, @"1");
}

- (void)testLastObject
{
    NSArray *array = @[@"1", @"2", [NSNull null], @"3", [NSNull null]];
    NSArray *compactArray = [array cu_compactArray];
    
    XCTAssertEqualObjects(compactArray.lastObject, @"3");
}

- (void)testObjectEnumerator
{
    NSArray *array = [self sampleArray];
    NSArray *compactArray = [array cu_compactArray];
    
    NSEnumerator *enumerator = compactArray.objectEnumerator;
    id object = nil;
    NSInteger i = 0;
    while ((object = enumerator.nextObject)) {
        if (i == 0) {
            XCTAssertEqualObjects(object, @"0");
        }
        if (i == 1) {
            XCTAssertEqualObjects(object, @"1");
        }
        if (i == 2) {
            XCTAssertEqualObjects(object, @"2");
        }
        if (i == 3) {
            XCTAssertEqualObjects(object, @"3");
        }
        i++;
    }
}

- (void)testReverseObjectEnumerator
{
    NSArray *array = [self sampleArray];
    NSArray *compactArray = [array cu_compactArray];
    
    NSEnumerator *enumerator = compactArray.reverseObjectEnumerator;
    id object = nil;
    NSInteger i = 0;
    while ((object = enumerator.nextObject)) {
        if (i == 0) {
            XCTAssertEqualObjects(object, @"3");
        }
        if (i == 1) {
            XCTAssertEqualObjects(object, @"2");
        }
        if (i == 2) {
            XCTAssertEqualObjects(object, @"1");
        }
        if (i == 3) {
            XCTAssertEqualObjects(object, @"0");
        }
        i++;
    }
}

static NSComparisonResult stringSort(id str1, id str2, void *context)
{
    return [str1 compare:str2];
}

- (void)testSortedArrayUsingFunction
{
    NSArray *array = @[@"2", @"1", [NSNull null], @"0", [NSNull null], @"3"];
    NSArray *compactArray = [array cu_compactArray];
    
    NSArray *sortedArray = [compactArray sortedArrayUsingFunction:stringSort context:NULL];
    
    XCTAssertEqualObjects(sortedArray[0], @"0");
    XCTAssertEqualObjects(sortedArray[1], @"1");
    XCTAssertEqualObjects(sortedArray[2], @"2");
    XCTAssertEqualObjects(sortedArray[3], @"3");
}

- (void)testSortedArrayUsingSelector
{
    NSArray *array = @[@"2", @"1", [NSNull null], @"0", [NSNull null], @"3"];
    NSArray *compactArray = [array cu_compactArray];
    
    NSArray *sortedArray = [compactArray sortedArrayUsingSelector:@selector(compare:)];
    
    XCTAssertEqualObjects(sortedArray[0], @"0");
    XCTAssertEqualObjects(sortedArray[1], @"1");
    XCTAssertEqualObjects(sortedArray[2], @"2");
    XCTAssertEqualObjects(sortedArray[3], @"3");
}

- (void)testSubarrayWithRange
{
    NSArray *array = [self sampleArray];
    NSArray *compactArray = [array cu_compactArray];
    
    NSArray *subArray1 = [compactArray subarrayWithRange:NSMakeRange(0, 2)];
    NSArray *subArray2 = [compactArray subarrayWithRange:NSMakeRange(1, 3)];
    
    XCTAssertEqualObjects(subArray1[0], @"0");
    XCTAssertEqualObjects(subArray1[1], @"1");
    
    XCTAssertEqualObjects(subArray2[0], @"1");
    XCTAssertEqualObjects(subArray2[1], @"2");
    XCTAssertEqualObjects(subArray2[2], @"3");
}

- (void)testWriteToFile
{
    NSArray *array = [self sampleArray];
    NSArray *compactArray = [array cu_compactArray];
    
    NSString *temporaryDirectory = NSTemporaryDirectory();
    NSString *path = [temporaryDirectory stringByAppendingPathComponent:@"array.temp"];
    
    XCTAssertFalse([array writeToFile:path atomically:YES]);
    XCTAssertFalse([array writeToURL:[NSURL fileURLWithPath:path] atomically:YES]);
    
    XCTAssertTrue([compactArray writeToFile:path atomically:YES]);
    XCTAssertTrue([compactArray writeToURL:[NSURL fileURLWithPath:path] atomically:YES]);
}

- (void)testMakeObjectsPerformSelector
{
    NSArray *array = [self sampleArray];
    NSArray *compactArray = [array cu_compactArray];
    
    XCTAssertThrows([array makeObjectsPerformSelector:@selector(length)]);
    XCTAssertThrows([array makeObjectsPerformSelector:@selector(compare:) withObject:@"1"]);
    
    XCTAssertNoThrow([compactArray makeObjectsPerformSelector:@selector(length)]);
    XCTAssertNoThrow([compactArray makeObjectsPerformSelector:@selector(compare:) withObject:@"1"]);
}

- (void)testObjectsAtIndexes
{
    NSArray *array = [self sampleArray];
    NSArray *compactArray = [array cu_compactArray];
    
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    [indexSet addIndex:0];
    [indexSet addIndex:2];
    [indexSet addIndex:3];
    
    NSArray *subarray = [compactArray objectsAtIndexes:indexSet];
    
    XCTAssertEqualObjects(subarray[0], @"0");
    XCTAssertEqualObjects(subarray[1], @"2");
    XCTAssertEqualObjects(subarray[2], @"3");
}

- (void)testObjectAtIndexedSubscript
{
    NSArray *array = [self sampleArray];
    NSArray *compactArray = [array cu_compactArray];
    
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"2");
    XCTAssertEqualObjects(compactArray[3], @"3");
}

- (void)testEnumerateObjectsUsingBlock
{
    NSArray *array = [self sampleArray];
    NSArray *compactArray = [array cu_compactArray];
    
    [compactArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx == 0) {
            XCTAssertEqualObjects(obj, @"0");
        }
        if (idx == 1) {
            XCTAssertEqualObjects(obj, @"1");
        }
        if (idx == 2) {
            XCTAssertEqualObjects(obj, @"2");
        }
        if (idx == 3) {
            XCTAssertEqualObjects(obj, @"3");
        }
    }];
    
    [compactArray enumerateObjectsWithOptions:NSEnumerationConcurrent | NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx == 0) {
            XCTAssertEqualObjects(obj, @"0");
        }
        if (idx == 1) {
            XCTAssertEqualObjects(obj, @"1");
        }
        if (idx == 2) {
            XCTAssertEqualObjects(obj, @"2");
        }
        if (idx == 3) {
            XCTAssertEqualObjects(obj, @"3");
        }
    }];
    
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    [indexSet addIndex:0];
    [indexSet addIndex:2];
    [indexSet addIndex:3];
    
    [compactArray enumerateObjectsAtIndexes:indexSet options:kNilOptions usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx == 0) {
            XCTAssertEqualObjects(obj, @"0");
        }
        if (idx == 1) {
            XCTFail(@"Should not reach here.");
        }
        if (idx == 2) {
            XCTAssertEqualObjects(obj, @"2");
        }
        if (idx == 3) {
            XCTAssertEqualObjects(obj, @"3");
        }
    }];
    
    [compactArray enumerateObjectsAtIndexes:indexSet options:NSEnumerationConcurrent | NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx == 0) {
            XCTAssertEqualObjects(obj, @"0");
        }
        if (idx == 1) {
            XCTFail(@"Should not reach here.");
        }
        if (idx == 2) {
            XCTAssertEqualObjects(obj, @"2");
        }
        if (idx == 3) {
            XCTAssertEqualObjects(obj, @"3");
        }
    }];
}

- (void)testIndexOfObjectPassingTest
{
    NSArray *array = [self sampleArray];
    NSArray *compactArray = [array cu_compactArray];
    
    NSUInteger index = NSNotFound;
    index = [compactArray indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        NSString *str = obj;
        return [str isEqualToString:@"2"];
    }];
    
    XCTAssertEqual(index, (NSUInteger)2);
    
    index = [compactArray indexOfObjectWithOptions:NSEnumerationConcurrent | NSEnumerationReverse passingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        NSString *str = obj;
        return [str isEqualToString:@"2"];
    }];
    
    XCTAssertEqual(index, (NSUInteger)2);
    
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    [indexSet addIndex:0];
    [indexSet addIndex:2];
    [indexSet addIndex:3];
    
    index = [compactArray indexOfObjectAtIndexes:indexSet options:NSEnumerationConcurrent | NSEnumerationReverse passingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        NSString *str = obj;
        return [str isEqualToString:@"2"];
    }];
    
    XCTAssertEqual(index, (NSUInteger)2);
}

- (void)testIndexesOfObjectsPassingTest
{
    NSArray *array = [self sampleArray];
    NSArray *compactArray = [array cu_compactArray];
    
    NSMutableIndexSet *expectedIndexSet = [NSMutableIndexSet indexSet];
    [expectedIndexSet addIndex:2];
    [expectedIndexSet addIndex:3];
    
    NSIndexSet *indexes = nil;
    indexes = [compactArray indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        NSString *str = obj;
        return [str isEqualToString:@"2"] || [str isEqualToString:@"3"];
    }];
    
    XCTAssertEqualObjects(indexes, expectedIndexSet);
    
    indexes = [compactArray indexesOfObjectsWithOptions:NSEnumerationConcurrent | NSEnumerationReverse passingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        NSString *str = obj;
        return [str isEqualToString:@"2"] || [str isEqualToString:@"3"];
    }];
    
    XCTAssertEqualObjects(indexes, expectedIndexSet);
    
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    [indexSet addIndex:0];
    [indexSet addIndex:2];
    [indexSet addIndex:3];
    
    indexes = [compactArray indexesOfObjectsAtIndexes:indexSet options:NSEnumerationConcurrent | NSEnumerationReverse passingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        NSString *str = obj;
        return [str isEqualToString:@"2"] || [str isEqualToString:@"3"];
    }];
    
    XCTAssertEqualObjects(indexes, expectedIndexSet);
}

- (void)testFastEnumeration
{
    NSArray *array = [self sampleArray];
    NSArray *compactArray = [array cu_compactArray];
    
    NSInteger counter = 0;
    for (id object in compactArray) {
        if (counter == 0) {
            XCTAssertEqualObjects(object, @"0");
        }
        if (counter == 1) {
            XCTAssertEqualObjects(object, @"1");
        }
        if (counter == 2) {
            XCTAssertEqualObjects(object, @"2");
        }
        if (counter == 3) {
            XCTAssertEqualObjects(object, @"3");
        }
        counter++;
    }
}

- (void)testSortedArrayUsingComparator
{
    NSArray *array = @[@"2", @"1", [NSNull null], @"0", [NSNull null], @"3"];
    NSArray *compactArray = [array cu_compactArray];
    
    NSArray *sortedArray = [compactArray sortedArrayWithOptions:NSSortStable usingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *str1 = obj1;
        NSString *str2 = obj2;
        return [str1 compare:str2];
    }];
    
    XCTAssertEqualObjects(sortedArray[0], @"0");
    XCTAssertEqualObjects(sortedArray[1], @"1");
    XCTAssertEqualObjects(sortedArray[2], @"2");
    XCTAssertEqualObjects(sortedArray[3], @"3");
}

- (void)testBinarySearch
{
    NSArray *array = [self sampleArray];
    NSArray *compactArray = [array cu_compactArray];
    
    NSUInteger index = NSNotFound;
    index = [compactArray indexOfObject:@"3" inSortedRange:NSMakeRange(0, compactArray.count) options:NSBinarySearchingFirstEqual usingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *str1 = obj1;
        NSString *str2 = obj2;
        return [str1 compare:str2];
    }];
    
    XCTAssertEqual(index, (NSUInteger)3);
}

#pragma mark - NSCopying

- (void)testCopy
{
    NSArray *array = [self sampleArray];
    NSArray *compactArray = [array cu_compactArray];
    NSArray *copied = compactArray.copy;
    
    XCTAssertEqualObjects(copied, compactArray);
}

#pragma mark - NSMutableCopying

- (void)testMutableCopy
{
    NSArray *array = [self sampleArray];
    NSArray *compactArray = [array cu_compactArray];
    NSArray *copied = compactArray.mutableCopy;
    
    XCTAssertTrue([copied isKindOfClass:[NSMutableArray class]]);
    XCTAssertEqualObjects(copied, compactArray);
}

#pragma mark - NSCoding

- (void)testArchiveObject
{
    NSArray *array = [self sampleArray];
    NSArray *compactArray = [array cu_compactArray];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:compactArray];
    NSArray *unarchived = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    XCTAssertEqualObjects(unarchived, compactArray);
    
    XCTAssertEqualObjects(unarchived[0], @"0");
    XCTAssertEqualObjects(unarchived[1], @"1");
    XCTAssertEqualObjects(unarchived[2], @"2");
    XCTAssertEqualObjects(unarchived[3], @"3");
}

@end
