//
//  CUCompactDictionary.m
//  CollectionUtils
//
//  Created by kishikawa katsumi on 2014/04/06.
//  Copyright (c) 2014 kishikawa katsumi. All rights reserved.
//

#import "CUCompactDictionary.h"
#import "CUCompactArray.h"

@interface CUCompactDictionary ()

@property (nonatomic) NSDictionary *original;

@end

@implementation CUCompactDictionary

#pragma mark - initializers

- (instancetype)init
{
    self = [super init];
    if (self) {
        _original = [[NSDictionary alloc] init];
    }
    return self;
}

- (instancetype)initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt
{
    self = [super init];
    if (self) {
        NSNull *nul = [NSNull null];
        NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] initWithCapacity:cnt];
        for (NSUInteger i = 0; i < cnt; i++) {
            id key = keys[i];
            id object = objects[i];
            if (key && object && object != nul) {
                mutableDictionary[key] = object;
            }
        }
        _original = mutableDictionary;
    }
    return self;
}

#pragma mark - primitive instance methods

- (NSUInteger)count
{
    return self.original.count;
}

- (id)objectForKey:(id)aKey
{
    id object = self.original[aKey];
    if ([object isKindOfClass:[CUCompactArray class]] || [object isKindOfClass:[CUCompactDictionary class]]) {
        return object;
    }
    if ([object isKindOfClass:[NSArray class]]) {
        return [[CUCompactArray alloc] initWithArray:object];
    }
    if ([object isKindOfClass:[NSDictionary class]]) {
        return [[CUCompactDictionary alloc] initWithDictionary:object];
    }
    return object;
}

- (NSEnumerator *)keyEnumerator
{
    return self.original.keyEnumerator;
}

#pragma mark -

- (BOOL)isEqualToDictionary:(NSDictionary *)otherDictionary
{
    NSDictionary *dictionary = [CUCompactDictionary dictionaryWithDictionary:otherDictionary];
    return [super isEqualToDictionary:dictionary];
}

#pragma mark - NSCopying protocol methods

- (id)copyWithZone:(NSZone *)zone
{
    return [CUCompactDictionary dictionaryWithDictionary:self.original];
}

#pragma mark - NSMutableCopying protocol methods

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return [CUCompactMutableDictionary dictionaryWithDictionary:self.original];
}

@end

@interface CUCompactMutableDictionary ()

@property (nonatomic) NSMutableDictionary *original;

@end

@implementation CUCompactMutableDictionary

#pragma mark - initializers

- (instancetype)init
{
    self = [super init];
    if (self) {
        _original = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (instancetype)initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt
{
    self = [super init];
    if (self) {
        NSNull *nul = [NSNull null];
        NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] initWithCapacity:cnt];
        for (NSUInteger i = 0; i < cnt; i++) {
            id key = keys[i];
            id object = objects[i];
            if (key && object && object != nul) {
                mutableDictionary[key] = object;
            }
        }
        _original = mutableDictionary;
    }
    return self;
}

#pragma mark - primitive instance methods

- (NSUInteger)count
{
    return self.original.count;
}

- (id)objectForKey:(id)aKey
{
    id object = self.original[aKey];
    if ([object isKindOfClass:[CUCompactArray class]] || [object isKindOfClass:[CUCompactDictionary class]]) {
        return object;
    }
    if ([object isKindOfClass:[NSArray class]]) {
        NSMutableArray *array = [CUCompactMutableArray arrayWithArray:object];
        [self.original setObject:array forKey:aKey];
        return array;
    }
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dictionary = [CUCompactMutableDictionary dictionaryWithDictionary:object];
        [self.original setObject:dictionary forKey:aKey];
        return dictionary;
    }
    return object;
}

- (NSEnumerator *)keyEnumerator
{
    return self.original.keyEnumerator;
}

- (void)removeObjectForKey:(id)aKey
{
    [self.original removeObjectForKey:aKey];
}

- (void)setObject:(id)anObject forKey:(id <NSCopying>)aKey
{
    if (!anObject || anObject == [NSNull null]) {
        [self.original removeObjectForKey:aKey];
    } else {
        [self.original setObject:anObject forKey:aKey];
    }
}

#pragma mark -

- (BOOL)isEqualToDictionary:(NSDictionary *)otherDictionary
{
    NSDictionary *dictionary = [CUCompactDictionary dictionaryWithDictionary:otherDictionary];
    return [super isEqualToDictionary:dictionary];
}

#pragma mark - NSCopying protocol methods

- (id)copyWithZone:(NSZone *)zone
{
    return [CUCompactDictionary dictionaryWithDictionary:self.original];
}

#pragma mark - NSMutableCopying protocol methods

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return [CUCompactMutableDictionary dictionaryWithDictionary:self.original];
}

@end
