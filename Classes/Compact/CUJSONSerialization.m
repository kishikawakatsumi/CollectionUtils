//
//  CUJSONSerialization.m
//  CollectionUtils
//
//  Created by kishikawa katsumi on 2014/04/07.
//  Copyright (c) 2014 kishikawa katsumi. All rights reserved.
//

#import "CUJSONSerialization.h"
#import "Compact.h"

@implementation CUJSONSerialization

+ (id)JSONObjectWithData:(NSData *)data options:(NSJSONReadingOptions)opt error:(NSError *__autoreleasing *)error
{
    id object = [NSJSONSerialization JSONObjectWithData:data options:opt error:error];
    return [object cu_compactJSONObject];
}

+ (id)JSONObjectWithStream:(NSInputStream *)stream options:(NSJSONReadingOptions)opt error:(NSError *__autoreleasing *)error
{
    id object = [NSJSONSerialization JSONObjectWithStream:stream options:opt error:error];
    return [object cu_compactJSONObject];
}

@end
