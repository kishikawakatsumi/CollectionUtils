//
//  CUCompactArray.m
//  CollectionUtils
//
//  Created by kishikawa katsumi on 2014/04/06.
//  Copyright (c) 2014 kishikawa katsumi. All rights reserved.
//

#import "CUCompactArray.h"
#import "CUCompactDictionary.h"

@interface CUCompactArray ()

@property (nonatomic) NSMutableArray *original;

@end

@implementation CUCompactArray

#pragma mark - initializers

- (instancetype)init
{
    self = [super init];
    if (self) {
        _original = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype)initWithObjects:(const id [])objects count:(NSUInteger)cnt
{
    self = [super init];
    if (self) {
        NSNull *nul = [NSNull null];
        NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:cnt];
        for (NSUInteger i = 0; i < cnt; i++) {
            id object = objects[i];
            if (object && object != nul) {
                [mutableArray addObject:object];
            }
        }
        _original = mutableArray;
        
    }
    return self;
}

#pragma mark - primitive instance methods

- (NSUInteger)count
{
    return self.original.count;
}

- (id)objectAtIndex:(NSUInteger)index
{
    id object = self.original[index];
    if ([object isKindOfClass:[CUCompactArray class]] || [object isKindOfClass:[CUCompactDictionary class]]) {
        return object;
    }
    if ([object isKindOfClass:[NSArray class]]) {
        return [CUCompactArray arrayWithArray:object];
    }
    if ([object isKindOfClass:[NSDictionary class]]) {
        return [CUCompactDictionary dictionaryWithDictionary:object];
    }
    return object;
}

#pragma mark -

- (NSArray *)arrayByAddingObject:(id)anObject
{
    if (!anObject || anObject == [NSNull null]) {
        return self;
    }
    [self.original addObject:anObject];
    return [CUCompactArray arrayWithArray:self.original];
}

- (BOOL)isEqualToArray:(NSArray *)otherArray
{
    NSArray *array = [CUCompactArray arrayWithArray:otherArray];
    return [super isEqualToArray:array];
}

#pragma mark - NSCopying protocol methods

- (id)copyWithZone:(NSZone *)zone
{
    return [CUCompactArray arrayWithArray:self.original];
}

#pragma mark - NSMutableCopying protocol methods

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return [CUCompactMutableArray arrayWithArray:self.original];
}

@end

@interface CUCompactMutableArray ()

@property (nonatomic) NSMutableArray *original;

@end

@implementation CUCompactMutableArray

#pragma mark - initializers

- (instancetype)init
{
    self = [super init];
    if (self) {
        _original = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype)initWithObjects:(const id [])objects count:(NSUInteger)cnt
{
    self = [super init];
    if (self) {
        NSNull *nul = [NSNull null];
        NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:cnt];
        for (NSUInteger i = 0; i < cnt; i++) {
            id object = objects[i];
            if (object && object != nul) {
                [mutableArray addObject:object];
            }
        }
        _original = mutableArray;
        
    }
    return self;
}

#pragma mark - primitive instance methods

- (NSUInteger)count
{
    return self.original.count;
}

- (id)objectAtIndex:(NSUInteger)index
{
    id object = self.original[index];
    if ([object isKindOfClass:[CUCompactMutableArray class]] || [object isKindOfClass:[CUCompactMutableDictionary class]]) {
        return object;
    }
    if ([object isKindOfClass:[NSArray class]]) {
        NSArray *array = [CUCompactMutableArray arrayWithArray:object];
        [self.original replaceObjectAtIndex:index withObject:array];
        return array;
    }
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = [CUCompactMutableDictionary dictionaryWithDictionary:object];
        [self.original replaceObjectAtIndex:index withObject:dictionary];
        return dictionary;
    }
    return object;
}

- (void)addObject:(id)anObject
{
    if (!anObject || anObject == [NSNull null]) {
        return;
    }
    [self.original addObject:anObject];
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (!anObject || anObject == [NSNull null]) {
        return;
    }
    [self.original insertObject:anObject atIndex:index];
}

- (void)removeLastObject
{
    [self.original removeLastObject];
}

- (void)removeObjectAtIndex:(NSUInteger)index
{
    [self.original removeObjectAtIndex:index];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (!anObject || anObject == [NSNull null]) {
        [self.original removeObjectAtIndex:index];
    } else {
        [self.original replaceObjectAtIndex:index withObject:anObject];
    }
}

#pragma mark -

- (NSArray *)arrayByAddingObject:(id)anObject
{
    if (!anObject || anObject == [NSNull null]) {
        return self;
    }
    [self.original addObject:anObject];
    return [CUCompactMutableArray arrayWithArray:self.original];
}

- (BOOL)isEqualToArray:(NSArray *)otherArray
{
    NSArray *array = [CUCompactArray arrayWithArray:otherArray];
    return [super isEqualToArray:array];
}

#pragma mark -

- (void)addObjectsFromArray:(NSArray *)otherArray
{
    for (id object in otherArray) {
        [self addObject:object];
    }
}

- (void)replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray
{
    [self.original replaceObjectsInRange:range withObjectsFromArray:otherArray];
    [self.original removeObjectIdenticalTo:[NSNull null]];
}

- (void)replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray range:(NSRange)otherRange
{
    [self.original replaceObjectsInRange:range withObjectsFromArray:otherArray range:otherRange];
    [self.original removeObjectIdenticalTo:[NSNull null]];
}

- (void)setArray:(NSArray *)otherArray
{
    NSMutableArray *mutableArray = otherArray.mutableCopy;
    [mutableArray removeObjectIdenticalTo:[NSNull null]];
    
    _original = mutableArray;
}

- (void)insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes
{
    [self.original insertObjects:objects atIndexes:indexes];
    [self.original removeObjectIdenticalTo:[NSNull null]];
}

- (void)replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray *)objects
{
    [self.original replaceObjectsAtIndexes:indexes withObjects:objects];
    [self.original removeObjectIdenticalTo:[NSNull null]];
}

#pragma mark - NSCopying protocol methods

- (id)copyWithZone:(NSZone *)zone
{
    return [CUCompactArray arrayWithArray:self.original];
}

#pragma mark - NSMutableCopying protocol methods

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return [CUCompactMutableArray arrayWithArray:self.original];
}

@end
