//
//  CUJSONRequestOperation.m
//  CollectionUtils
//
//  Created by kishikawa katsumi on 2014/04/05.
//  Copyright (c) 2014 kishikawa katsumi. All rights reserved.
//

#import "CUJSONRequestOperation.h"
#import "Compact.h"

@implementation CUJSONRequestOperation

- (id)responseJSON
{
    id object = [super responseJSON];
    return [object cu_compactJSONObject];
}

@end
