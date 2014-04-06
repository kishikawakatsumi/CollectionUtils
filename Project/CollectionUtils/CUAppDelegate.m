//
//  CUAppDelegate.m
//  CollectionUtils
//
//  Created by kishikawa katsumi on 2014/04/07.
//  Copyright (c) 2014 kishikawa katsumi. All rights reserved.
//

#import "CUAppDelegate.h"
#import "CollectionUtils.h"

@implementation CUAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    NSArray *array = @[@"0",
//                       @"1",
//                       [NSNull null],
//                       @"2",
//                       [NSNull null],
//                       @"3"];
//    NSArray *compactArray = [array cu_compactArray];
//    NSLog(@"%@", compactArray);
//    
//    NSDictionary *dictionary = @{@"one": @"1",
//                                 @"null": [NSNull null],
//                                 @"two": @"2",
//                                 @"three": @"3"};
//    NSDictionary *compactDictionary = [dictionary cu_compactDictionary];
//    NSLog(@"%@", compactDictionary);
    
NSArray *array = @[@"0",
                   @"1",
                   [NSNull null],
                   @"2",
                   @{@"zero": @"0",
                     @"one": @"1",
                     @"null": [NSNull null],
                     @"two": @"2"},
                   @"4"];
NSMutableArray *compactArray = [[array cu_compactArray] mutableCopy];
NSLog(@"%@", compactArray);
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
