//
//  main.m
//  APValidators
//
//  Created by Nickolay Sheika on 03/14/2016.
//  Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import "APAppDelegate.h"

int main(int argc, char *argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSClassFromString(@"XCTestCase") != nil ? nil : NSStringFromClass([APAppDelegate class]));
    }
}
