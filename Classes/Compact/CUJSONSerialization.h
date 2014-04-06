//
//  CUJSONSerialization.h
//  CollectionUtils
//
//  Created by kishikawa katsumi on 2014/04/07.
//  Copyright (c) 2014 kishikawa katsumi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CUJSONSerialization : NSObject

+ (id)JSONObjectWithData:(NSData *)data options:(NSJSONReadingOptions)opt error:(NSError *__autoreleasing *)error;
+ (id)JSONObjectWithStream:(NSInputStream *)stream options:(NSJSONReadingOptions)opt error:(NSError *__autoreleasing *)error;

@end
