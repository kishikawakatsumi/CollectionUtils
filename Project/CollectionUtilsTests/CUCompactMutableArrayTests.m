//
//  CUCompactMutableArrayTests.m
//  CollectionUtils
//
//  Created by kishikawa katsumi on 2014/04/07.
//  Copyright (c) 2014年 kishikawa katsumi. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Compact.h"

@interface CUCompactMutableArrayTests : XCTestCase

@end

@implementation CUCompactMutableArrayTests

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

- (NSMutableArray *)sampleArray
{
    NSArray *array = @[@"0",
                       @"1",
                       [NSNull null],
                       @"2",
                       [NSNull null],
                       @"3"];
    return array.mutableCopy;
}

#pragma mark - test cases

#pragma mark - initializers

- (void)testArray
{
    NSMutableArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqual(compactArray.count, 4);
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
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqual(compactArray.count, 5);
    XCTAssertEqual([compactArray[3] count], 3);
}

#pragma mark - primitive instance methods

- (void)testCount
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqual(compactArray.count, 4);
}

- (void)testObjectAtIndex
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqualObjects([compactArray objectAtIndex:0], @"0");
    XCTAssertEqualObjects([compactArray objectAtIndex:1], @"1");
    XCTAssertEqualObjects([compactArray objectAtIndex:2], @"2");
    XCTAssertEqualObjects([compactArray objectAtIndex:3], @"3");
}

#pragma mark -

- (void)testArrayByAddingObject
{
    NSArray *array = [self sampleArray];
    NSArray *compactArray = [[array cu_compactArray] mutableCopy];
    
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
    NSArray *compactArray = [[array cu_compactArray] mutableCopy];
    
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
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    NSString *string = [compactArray componentsJoinedByString:@", "];
    XCTAssertEqualObjects(string, @"0, 1, 2, 3");
}

- (void)testContainsObject
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
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
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
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
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    id __unsafe_unretained objects[3];
    [compactArray getObjects:objects range:NSMakeRange(1, 3)];
    
    XCTAssertEqualObjects(objects[0], @"1");
    XCTAssertEqualObjects(objects[1], @"2");
    XCTAssertEqualObjects(objects[2], @"3");
}

- (void)testIndexOfObject
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqual([compactArray indexOfObject:@"0"], 0);
    XCTAssertEqual([compactArray indexOfObject:@"1"], 1);
    XCTAssertEqual([compactArray indexOfObject:@"2"], 2);
    XCTAssertEqual([compactArray indexOfObject:@"3"], 3);
    XCTAssertEqual([compactArray indexOfObject:@"4"], NSNotFound);
    XCTAssertEqual([compactArray indexOfObject:[NSNull null]], NSNotFound);
    XCTAssertEqual([compactArray indexOfObject:nil], NSNotFound);
    
    XCTAssertEqual([compactArray indexOfObject:@"0" inRange:NSMakeRange(0, 3)], 0);
    XCTAssertEqual([compactArray indexOfObject:@"1" inRange:NSMakeRange(0, 3)], 1);
    XCTAssertEqual([compactArray indexOfObject:@"2" inRange:NSMakeRange(0, 3)], 2);
    XCTAssertEqual([compactArray indexOfObject:@"3" inRange:NSMakeRange(0, 3)], NSNotFound);
}

- (void)testIndexOfObjectIdenticalTo
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqual([compactArray indexOfObjectIdenticalTo:@"0"], 0);
    XCTAssertEqual([compactArray indexOfObjectIdenticalTo:@"1"], 1);
    XCTAssertEqual([compactArray indexOfObjectIdenticalTo:@"2"], 2);
    XCTAssertEqual([compactArray indexOfObjectIdenticalTo:@"3"], 3);
    XCTAssertEqual([compactArray indexOfObjectIdenticalTo:@"4"], NSNotFound);
    
    XCTAssertEqual([compactArray indexOfObjectIdenticalTo:@"0" inRange:NSMakeRange(0, 3)], 0);
    XCTAssertEqual([compactArray indexOfObjectIdenticalTo:@"1" inRange:NSMakeRange(0, 3)], 1);
    XCTAssertEqual([compactArray indexOfObjectIdenticalTo:@"2" inRange:NSMakeRange(0, 3)], 2);
    XCTAssertEqual([compactArray indexOfObjectIdenticalTo:@"3" inRange:NSMakeRange(0, 3)], NSNotFound);
}

- (void)testIsEqualToArray
{
    NSArray *array = @[@"0", @"1", [NSNull null], @"2", [NSNull null], @"3"];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertTrue([compactArray isEqualToArray:(@[@"0", @"1", @"2", @"3"])]);
}

- (void)testFirstObject
{
    NSArray *array = @[[NSNull null], @"1", [NSNull null], @"2", [NSNull null], @"3"];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqualObjects(compactArray.firstObject, @"1");
}

- (void)testLastObject
{
    NSArray *array = @[@"1", @"2", [NSNull null], @"3", [NSNull null]];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqualObjects(compactArray.lastObject, @"3");
}

- (void)testObjectEnumerator
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
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
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
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
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    NSArray *sortedArray = [compactArray sortedArrayUsingFunction:stringSort context:NULL];
    
    XCTAssertEqualObjects(sortedArray[0], @"0");
    XCTAssertEqualObjects(sortedArray[1], @"1");
    XCTAssertEqualObjects(sortedArray[2], @"2");
    XCTAssertEqualObjects(sortedArray[3], @"3");
}

- (void)testSortedArrayUsingSelector
{
    NSArray *array = @[@"2", @"1", [NSNull null], @"0", [NSNull null], @"3"];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    NSArray *sortedArray = [compactArray sortedArrayUsingSelector:@selector(compare:)];
    
    XCTAssertEqualObjects(sortedArray[0], @"0");
    XCTAssertEqualObjects(sortedArray[1], @"1");
    XCTAssertEqualObjects(sortedArray[2], @"2");
    XCTAssertEqualObjects(sortedArray[3], @"3");
}

- (void)testSubarrayWithRange
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
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
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
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
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertThrows([array makeObjectsPerformSelector:@selector(length)]);
    XCTAssertThrows([array makeObjectsPerformSelector:@selector(compare:) withObject:@"1"]);
    
    XCTAssertNoThrow([compactArray makeObjectsPerformSelector:@selector(length)]);
    XCTAssertNoThrow([compactArray makeObjectsPerformSelector:@selector(compare:) withObject:@"1"]);
}

- (void)testObjectsAtIndexes
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
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
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"2");
    XCTAssertEqualObjects(compactArray[3], @"3");
}

- (void)testEnumerateObjectsUsingBlock
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
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
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    NSUInteger index = NSNotFound;
    index = [compactArray indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        NSString *str = obj;
        return [str isEqualToString:@"2"];
    }];
    
    XCTAssertEqual(index, 2);
    
    index = [compactArray indexOfObjectWithOptions:NSEnumerationConcurrent | NSEnumerationReverse passingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        NSString *str = obj;
        return [str isEqualToString:@"2"];
    }];
    
    XCTAssertEqual(index, 2);
    
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    [indexSet addIndex:0];
    [indexSet addIndex:2];
    [indexSet addIndex:3];
    
    index = [compactArray indexOfObjectAtIndexes:indexSet options:NSEnumerationConcurrent | NSEnumerationReverse passingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        NSString *str = obj;
        return [str isEqualToString:@"2"];
    }];
    
    XCTAssertEqual(index, 2);
}

- (void)testIndexesOfObjectsPassingTest
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
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
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
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
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
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
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    NSUInteger index = NSNotFound;
    index = [compactArray indexOfObject:@"3" inSortedRange:NSMakeRange(0, compactArray.count) options:NSBinarySearchingFirstEqual usingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *str1 = obj1;
        NSString *str2 = obj2;
        return [str1 compare:str2];
    }];
    
    XCTAssertEqual(index, 3);
}

#pragma mark - NSCopying

- (void)testCopy
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    NSArray *copied = compactArray.copy;
    
    XCTAssertEqualObjects(copied, compactArray);
}

#pragma mark - NSMutableCopying

- (void)testMutableCopy
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    NSArray *copied = compactArray.mutableCopy;
    
    XCTAssertTrue([copied isKindOfClass:[NSMutableArray class]]);
    XCTAssertEqualObjects(copied, compactArray);
}

#pragma mark - NSCoding

- (void)testArchiveObject
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:compactArray];
    NSArray *unarchived = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    XCTAssertEqualObjects(unarchived, compactArray);
    
    XCTAssertEqualObjects(unarchived[0], @"0");
    XCTAssertEqualObjects(unarchived[1], @"1");
    XCTAssertEqualObjects(unarchived[2], @"2");
    XCTAssertEqualObjects(unarchived[3], @"3");
}

#pragma mark -

- (void)testAddObject
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    [compactArray addObject:@"4"];
    [compactArray addObject:[NSNull null]];
    [compactArray addObject:nil];
    [compactArray addObject:@"5"];
    
    XCTAssertEqualObjects([compactArray objectAtIndex:0], @"0");
    XCTAssertEqualObjects([compactArray objectAtIndex:1], @"1");
    XCTAssertEqualObjects([compactArray objectAtIndex:2], @"2");
    XCTAssertEqualObjects([compactArray objectAtIndex:3], @"3");
    XCTAssertEqualObjects([compactArray objectAtIndex:4], @"4");
    XCTAssertEqualObjects([compactArray objectAtIndex:5], @"5");
}

- (void)testInsertObject
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    [compactArray insertObject:@"4" atIndex:1];
    [compactArray insertObject:[NSNull null] atIndex:1];
    [compactArray insertObject:nil atIndex:1];
    [compactArray insertObject:@"5" atIndex:1];
    
    XCTAssertEqualObjects([compactArray objectAtIndex:0], @"0");
    XCTAssertEqualObjects([compactArray objectAtIndex:1], @"5");
    XCTAssertEqualObjects([compactArray objectAtIndex:2], @"4");
    XCTAssertEqualObjects([compactArray objectAtIndex:3], @"1");
    XCTAssertEqualObjects([compactArray objectAtIndex:4], @"2");
    XCTAssertEqualObjects([compactArray objectAtIndex:5], @"3");
}

- (void)testRemoveLastObject
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqual(compactArray.count, 4);
    XCTAssertEqualObjects(compactArray.lastObject, @"3");
    
    [compactArray removeLastObject];
    
    XCTAssertEqual(compactArray.count, 3);
    XCTAssertEqualObjects(compactArray.lastObject, @"2");
    
    [compactArray removeLastObject];
    
    XCTAssertEqual(compactArray.count, 2);
    XCTAssertEqualObjects(compactArray.lastObject, @"1");
    
    [compactArray removeLastObject];
    
    XCTAssertEqual(compactArray.count, 1);
    XCTAssertEqualObjects(compactArray.lastObject, @"0");
    
    [compactArray removeLastObject];
    
    XCTAssertEqual(compactArray.count, 0);
}

- (void)testRemoveObjectAtIndex
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqual(compactArray.count, 4);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"2");
    XCTAssertEqualObjects(compactArray[3], @"3");
    
    [compactArray removeObjectAtIndex:1];
    
    XCTAssertEqual(compactArray.count, 3);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"2");
    XCTAssertEqualObjects(compactArray[2], @"3");
    
    [compactArray removeObjectAtIndex:1];
    
    XCTAssertEqual(compactArray.count, 2);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"3");
}

- (void)testReplaceObjectAtIndex
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqual(compactArray.count, 4);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"2");
    XCTAssertEqualObjects(compactArray[3], @"3");
    
    [compactArray replaceObjectAtIndex:1 withObject:@"4"];
    
    XCTAssertEqual(compactArray.count, 4);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"4");
    XCTAssertEqualObjects(compactArray[2], @"2");
    XCTAssertEqualObjects(compactArray[3], @"3");
    
    [compactArray replaceObjectAtIndex:2 withObject:@"5"];
    
    XCTAssertEqual(compactArray.count, 4);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"4");
    XCTAssertEqualObjects(compactArray[2], @"5");
    XCTAssertEqualObjects(compactArray[3], @"3");
    
    [compactArray replaceObjectAtIndex:2 withObject:nil];
    
    XCTAssertEqual(compactArray.count, 3);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"4");
    XCTAssertEqualObjects(compactArray[2], @"3");
    
    [compactArray replaceObjectAtIndex:1 withObject:[NSNull null]];
    
    XCTAssertEqual(compactArray.count, 2);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"3");
}

- (void)testAddObjectsFromArray
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqual(compactArray.count, 4);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"2");
    XCTAssertEqualObjects(compactArray[3], @"3");
    
    [compactArray addObjectsFromArray:array.copy];
    
    XCTAssertEqual(compactArray.count, 8);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"2");
    XCTAssertEqualObjects(compactArray[3], @"3");
    XCTAssertEqualObjects(compactArray[4], @"0");
    XCTAssertEqualObjects(compactArray[5], @"1");
    XCTAssertEqualObjects(compactArray[6], @"2");
    XCTAssertEqualObjects(compactArray[7], @"3");
}

- (void)testExchangeObjectAtIndexWithObjectAtIndex
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqual(compactArray.count, 4);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"2");
    XCTAssertEqualObjects(compactArray[3], @"3");
    
    [compactArray exchangeObjectAtIndex:1 withObjectAtIndex:2];
    
    XCTAssertEqual(compactArray.count, 4);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"2");
    XCTAssertEqualObjects(compactArray[2], @"1");
    XCTAssertEqualObjects(compactArray[3], @"3");
}

- (void)testRemoveAllObjects
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqual(compactArray.count, 4);
    
    [compactArray removeAllObjects];
    
    XCTAssertEqual(compactArray.count, 0);
}

- (void)testRemoveObjectInRange
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqual(compactArray.count, 4);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"2");
    XCTAssertEqualObjects(compactArray[3], @"3");
    
    [compactArray removeObject:@"2" inRange:NSMakeRange(1, 2)];
    
    XCTAssertEqual(compactArray.count, 3);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"3");
    
    [compactArray removeObject:nil inRange:NSMakeRange(1, 2)];
    
    XCTAssertEqual(compactArray.count, 3);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"3");
    
    [compactArray removeObject:[NSNull null] inRange:NSMakeRange(1, 2)];
    
    XCTAssertEqual(compactArray.count, 3);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"3");
}

- (void)testRemoveObject
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqual(compactArray.count, 4);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"2");
    XCTAssertEqualObjects(compactArray[3], @"3");
    
    [compactArray removeObject:@"2"];
    
    XCTAssertEqual(compactArray.count, 3);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"3");
    
    [compactArray removeObject:nil];
    
    XCTAssertEqual(compactArray.count, 3);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"3");
    
    [compactArray removeObject:[NSNull null]];
    
    XCTAssertEqual(compactArray.count, 3);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"3");
}

- (void)testRemoveObjectIdenticalTo
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqual(compactArray.count, 4);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"2");
    XCTAssertEqualObjects(compactArray[3], @"3");
    
    [compactArray removeObjectIdenticalTo:@"2"];
    
    XCTAssertEqual(compactArray.count, 3);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"3");
    
    [compactArray removeObjectIdenticalTo:nil];
    
    XCTAssertEqual(compactArray.count, 3);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"3");
    
    [compactArray removeObjectIdenticalTo:[NSNull null]];
    
    XCTAssertEqual(compactArray.count, 3);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"3");
}

- (void)testRemoveObjectIdenticalToInRange
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqual(compactArray.count, 4);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"2");
    XCTAssertEqualObjects(compactArray[3], @"3");
    
    [compactArray removeObjectIdenticalTo:@"2" inRange:NSMakeRange(1, 2)];
    
    XCTAssertEqual(compactArray.count, 3);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"3");
    
    [compactArray removeObjectIdenticalTo:nil inRange:NSMakeRange(1, 2)];
    
    XCTAssertEqual(compactArray.count, 3);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"3");
    
    [compactArray removeObjectIdenticalTo:[NSNull null] inRange:NSMakeRange(1, 2)];
    
    XCTAssertEqual(compactArray.count, 3);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"3");
}

- (void)testRemoveObjectsFromIndicesNumIndices
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqual(compactArray.count, 4);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"2");
    XCTAssertEqualObjects(compactArray[3], @"3");
    
    NSUInteger indices[2];
    indices[0] = 1;
    indices[1] = 2;
    
    [compactArray removeObjectsFromIndices:indices numIndices:2];
    
    XCTAssertEqual(compactArray.count, 2);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"3");
}

- (void)testRemoveObjectsInArray
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqual(compactArray.count, 4);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"2");
    XCTAssertEqualObjects(compactArray[3], @"3");
    
    [compactArray removeObjectsInArray:@[@"0", @"2", [NSNull null]]];
    
    XCTAssertEqual(compactArray.count, 2);
    XCTAssertEqualObjects(compactArray[0], @"1");
    XCTAssertEqualObjects(compactArray[1], @"3");
}

- (void)testRemoveObjectsInRange
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqual(compactArray.count, 4);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"2");
    XCTAssertEqualObjects(compactArray[3], @"3");
    
    [compactArray removeObjectsInRange:NSMakeRange(1, 2)];
    
    XCTAssertEqual(compactArray.count, 2);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"3");
}

- (void)testReplaceObjectsInRangeWithObjectsFromArray
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqual(compactArray.count, 4);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"2");
    XCTAssertEqualObjects(compactArray[3], @"3");
    
    [compactArray replaceObjectsInRange:NSMakeRange(1, 2) withObjectsFromArray:@[@"4", [NSNull null], @"5", @"6", @"7"]];
    
    XCTAssertEqual(compactArray.count, 6);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"4");
    XCTAssertEqualObjects(compactArray[2], @"5");
    XCTAssertEqualObjects(compactArray[3], @"6");
    XCTAssertEqualObjects(compactArray[4], @"7");
    XCTAssertEqualObjects(compactArray[5], @"3");
}

- (void)testReplaceObjectsInRangeWithObjectsFromArrayRange
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqual(compactArray.count, 4);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"2");
    XCTAssertEqualObjects(compactArray[3], @"3");
    
    [compactArray replaceObjectsInRange:NSMakeRange(1, 2) withObjectsFromArray:@[@"4", [NSNull null], @"5", @"6", @"7"] range:NSMakeRange(0, 3)];
    
    XCTAssertEqual(compactArray.count, 4);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"4");
    XCTAssertEqualObjects(compactArray[2], @"5");
    XCTAssertEqualObjects(compactArray[3], @"3");
}

- (void)testSetArray
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqual(compactArray.count, 4);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"2");
    XCTAssertEqualObjects(compactArray[3], @"3");
    
    [compactArray setArray:@[@"4", [NSNull null], @"5", @"6"]];
    
    XCTAssertEqual(compactArray.count, 3);
    XCTAssertEqualObjects(compactArray[0], @"4");
    XCTAssertEqualObjects(compactArray[1], @"5");
    XCTAssertEqualObjects(compactArray[2], @"6");
}

- (void)testSortUsingFunction
{
    NSArray *array = @[@"2", @"1", [NSNull null], @"0", [NSNull null], @"3"];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    [compactArray sortUsingFunction:stringSort context:NULL];
    
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"2");
    XCTAssertEqualObjects(compactArray[3], @"3");
}

- (void)testSortUsingSelector
{
    NSArray *array = @[@"2", @"1", [NSNull null], @"0", [NSNull null], @"3"];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    [compactArray sortUsingSelector:@selector(compare:)];
    
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"2");
    XCTAssertEqualObjects(compactArray[3], @"3");
}

- (void)testInsertObjectsAtIndexes1
{
    NSArray *array = @[@"one", @"two", [NSNull null], @"three", [NSNull null], @"four"];
    NSArray *newAdditions = @[@"a", @"b"];
    
    NSMutableIndexSet *indexes = [NSMutableIndexSet indexSet];
    [indexes addIndex:1];
    [indexes addIndex:3];
    
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    [compactArray insertObjects:newAdditions atIndexes:indexes];
    
    XCTAssertEqual(compactArray.count, 6);
    XCTAssertEqualObjects(compactArray[0], @"one");
    XCTAssertEqualObjects(compactArray[1], @"a");
    XCTAssertEqualObjects(compactArray[2], @"two");
    XCTAssertEqualObjects(compactArray[3], @"b");
    XCTAssertEqualObjects(compactArray[4], @"three");
    XCTAssertEqualObjects(compactArray[5], @"four");
}

- (void)testInsertObjectsAtIndexes2
{
    NSArray *array = @[@"one", @"two", [NSNull null], @"three", [NSNull null], @"four"];
    NSArray *newAdditions = @[@"a", [NSNull null], @"b", [NSNull null]];
    
    NSMutableIndexSet *indexes = [NSMutableIndexSet indexSet];
    [indexes addIndex:1];
    [indexes addIndex:3];
    [indexes addIndex:4];
    [indexes addIndex:5];
    
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    [compactArray insertObjects:newAdditions atIndexes:indexes];
    
    XCTAssertEqual(compactArray.count, 6);
    XCTAssertEqualObjects(compactArray[0], @"one");
    XCTAssertEqualObjects(compactArray[1], @"a");
    XCTAssertEqualObjects(compactArray[2], @"two");
    XCTAssertEqualObjects(compactArray[3], @"b");
    XCTAssertEqualObjects(compactArray[4], @"three");
    XCTAssertEqualObjects(compactArray[5], @"four");
}

- (void)testInsertObjectsAtIndexes3
{
    NSArray *array = @[@"one", @"two", [NSNull null], @"three", [NSNull null], @"four"];
    NSArray *newAdditions = @[@"a", @"b"];
    
    NSMutableIndexSet *indexes = [NSMutableIndexSet indexSet];
    [indexes addIndex:4];
    [indexes addIndex:5];
    
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    [compactArray insertObjects:newAdditions atIndexes:indexes];
    
    XCTAssertEqual(compactArray.count, 6);
    XCTAssertEqualObjects(compactArray[0], @"one");
    XCTAssertEqualObjects(compactArray[1], @"two");
    XCTAssertEqualObjects(compactArray[2], @"three");
    XCTAssertEqualObjects(compactArray[3], @"four");
    XCTAssertEqualObjects(compactArray[4], @"a");
    XCTAssertEqualObjects(compactArray[5], @"b");
}

- (void)testInsertObjectsAtIndexes4
{
    NSArray *array = @[@"one", @"two", [NSNull null], @"three", [NSNull null], @"four"];
    NSArray *newAdditions = @[@"a", [NSNull null], @"b", [NSNull null]];
    
    NSMutableIndexSet *indexes = [NSMutableIndexSet indexSet];
    [indexes addIndex:4];
    [indexes addIndex:5];
    [indexes addIndex:6];
    [indexes addIndex:7];
    
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    [compactArray insertObjects:newAdditions atIndexes:indexes];
    
    XCTAssertEqual(compactArray.count, 6);
    XCTAssertEqualObjects(compactArray[0], @"one");
    XCTAssertEqualObjects(compactArray[1], @"two");
    XCTAssertEqualObjects(compactArray[2], @"three");
    XCTAssertEqualObjects(compactArray[3], @"four");
    XCTAssertEqualObjects(compactArray[4], @"a");
    XCTAssertEqualObjects(compactArray[5], @"b");
}

- (void)testInsertObjectsAtIndexes5
{
    NSArray *array = @[@"one", @"two", [NSNull null], @"three", [NSNull null], @"four"];
    NSArray *newAdditions = @[@"a", @"b", @"c"];
    
    NSMutableIndexSet *indexes = [NSMutableIndexSet indexSet];
    [indexes addIndex:1];
    [indexes addIndex:2];
    [indexes addIndex:4];
    
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    [compactArray insertObjects:newAdditions atIndexes:indexes];
    
    XCTAssertEqual(compactArray.count, 7);
    XCTAssertEqualObjects(compactArray[0], @"one");
    XCTAssertEqualObjects(compactArray[1], @"a");
    XCTAssertEqualObjects(compactArray[2], @"b");
    XCTAssertEqualObjects(compactArray[3], @"two");
    XCTAssertEqualObjects(compactArray[4], @"c");
    XCTAssertEqualObjects(compactArray[5], @"three");
    XCTAssertEqualObjects(compactArray[6], @"four");
}

- (void)testInsertObjectsAtIndexes6
{
    NSArray *array = @[@"one", @"two", [NSNull null], @"three", [NSNull null], @"four"];
    NSArray *newAdditions = @[@"a", @"b", [NSNull null], @"c"];
    
    NSMutableIndexSet *indexes = [NSMutableIndexSet indexSet];
    [indexes addIndex:1];
    [indexes addIndex:2];
    [indexes addIndex:3];
    [indexes addIndex:4];
    
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    [compactArray insertObjects:newAdditions atIndexes:indexes];
    
    XCTAssertEqual(compactArray.count, 7);
    XCTAssertEqualObjects(compactArray[0], @"one");
    XCTAssertEqualObjects(compactArray[1], @"a");
    XCTAssertEqualObjects(compactArray[2], @"b");
    XCTAssertEqualObjects(compactArray[3], @"c");
    XCTAssertEqualObjects(compactArray[4], @"two");
    XCTAssertEqualObjects(compactArray[5], @"three");
    XCTAssertEqualObjects(compactArray[6], @"four");
}

- (void)testRemoveObjectsAtIndexes
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqual(compactArray.count, 4);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"2");
    XCTAssertEqualObjects(compactArray[3], @"3");
    
    NSMutableIndexSet *indexes = [NSMutableIndexSet indexSet];
    [indexes addIndex:1];
    [indexes addIndex:3];
    
    [compactArray removeObjectsAtIndexes:indexes];
    
    XCTAssertEqual(compactArray.count, 2);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"2");
}

- (void)testReplaceObjectsAtIndexesWithObjects
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqual(compactArray.count, 4);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"2");
    XCTAssertEqualObjects(compactArray[3], @"3");
    
    NSMutableIndexSet *indexes = [NSMutableIndexSet indexSet];
    [indexes addIndex:1];
    [indexes addIndex:2];
    [indexes addIndex:3];
    
    [compactArray replaceObjectsAtIndexes:indexes withObjects:@[@"a", [NSNull null], @"b"]];
    
    XCTAssertEqual(compactArray.count, 3);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"a");
    XCTAssertEqualObjects(compactArray[2], @"b");
}


- (void)testSetObjectAtIndexedSubscript
{
    NSArray *array = [self sampleArray];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    XCTAssertEqual(compactArray.count, 4);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"2");
    XCTAssertEqualObjects(compactArray[3], @"3");
    
    compactArray[2] = @"two";
    
    XCTAssertEqual(compactArray.count, 4);
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"two");
    XCTAssertEqualObjects(compactArray[3], @"3");
}

- (void)testSortUsingComparator
{
    NSArray *array = @[@"2", @"1", [NSNull null], @"0", [NSNull null], @"3"];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    [compactArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *str1 = obj1;
        NSString *str2 = obj2;
        return [str1 compare:str2];
    }];
    
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"2");
    XCTAssertEqualObjects(compactArray[3], @"3");
}

- (void)testSortWithOptionsUsingComparator
{
    NSArray *array = @[@"2", @"1", [NSNull null], @"0", [NSNull null], @"3"];
    NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
    
    [compactArray sortWithOptions:NSSortConcurrent | NSSortStable usingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *str1 = obj1;
        NSString *str2 = obj2;
        return [str1 compare:str2];
    }];
    
    XCTAssertEqualObjects(compactArray[0], @"0");
    XCTAssertEqualObjects(compactArray[1], @"1");
    XCTAssertEqualObjects(compactArray[2], @"2");
    XCTAssertEqualObjects(compactArray[3], @"3");
}

@end
