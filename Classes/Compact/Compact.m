//
//  Compact.m
//  CollectionUtils
//
//  Created by kishikawa katsumi on 2014/04/06.
//  Copyright (c) 2014 kishikawa katsumi. All rights reserved.
//

#import "Compact.h"

@implementation NSObject (CompactCollections)

- (id)cu_compactJSONObject
{
    id object = self;
    if ([object isKindOfClass:[NSArray class]]) {
        return [object cu_compactArray];
    }
    if ([object isKindOfClass:[NSDictionary class]]) {
        return [object cu_compactDictionary];
    }
    return object;
}

@end

@implementation NSArray (CompactCollections)

- (NSArray *)cu_compactArray
{
    return [CUCompactArray arrayWithArray:self];
}

@end

@implementation NSMutableArray (CompactCollections)

- (NSMutableArray *)cu_compactArray
{
    return [CUCompactMutableArray arrayWithArray:self];
}

@end

@implementation NSDictionary (CompactCollections)

- (NSDictionary *)cu_compactDictionary
{
    return [CUCompactDictionary dictionaryWithDictionary:self];
}

@end

@implementation NSMutableDictionary (CompactCollections)

- (NSMutableDictionary *)cu_compactDictionary
{
    return [CUCompactMutableDictionary dictionaryWithDictionary:self];
}

@end
