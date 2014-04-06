//
//  Compact.h
//  CollectionUtils
//
//  Created by kishikawa katsumi on 2014/04/06.
//  Copyright (c) 2014 kishikawa katsumi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CUCompactArray.h"
#import "CUCompactDictionary.h"
#import "CUJSONSerialization.h"

@interface NSObject (CompactCollections)

- (id)cu_compactJSONObject;

@end

@interface NSArray (CompactCollections)

- (NSArray *)cu_compactArray;

@end

@interface NSMutableArray (CompactCollections)

- (NSMutableArray *)cu_compactArray;

@end

@interface NSDictionary (CompactCollections)

- (NSDictionary *)cu_compactDictionary;

@end

@interface NSMutableDictionary (CompactCollections)

- (NSMutableDictionary *)cu_compactDictionary;

@end
