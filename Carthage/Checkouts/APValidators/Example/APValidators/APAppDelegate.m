//
//  APAppDelegate.m
//  APValidators
//
//  Created by Nickolay Sheika on 03/14/2016.
//  Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import "APAppDelegate.h"



@implementation APAppDelegate


- (BOOL)          application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = [storyboard instantiateInitialViewController];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];

    return YES;
}

@end
