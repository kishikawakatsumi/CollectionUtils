//
//  CUJSONResponseSerializer.m
//  CollectionUtils
//
//  Created by kishikawa katsumi on 2014/04/05.
//  Copyright (c) 2014年 kishikawa katsumi. All rights reserved.
//

#import "CUJSONResponseSerializer.h"
#import "Compact.h"

@implementation CUJSONResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    id responseObject = [super responseObjectForResponse:response data:data error:error];
    return [responseObject cu_compactJSONObject];
}

@end
