//
//  CUAppDelegate.m
//  CollectionUtils
//
//  Created by kishikawa katsumi on 2014/04/07.
//  Copyright (c) 2014 kishikawa katsumi. All rights reserved.
//

#import "CUAppDelegate.h"

@implementation CUAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
