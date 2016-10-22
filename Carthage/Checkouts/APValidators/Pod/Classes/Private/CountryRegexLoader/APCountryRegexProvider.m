//
// Created by Nickolay Sheika on 4/13/16.
// Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import "APCountryRegexProvider.h"



@implementation APCountryRegexProvider


+ (NSString *)regexForCountryWithCode:(NSString *)countryCode
{
    if (! countryCode) {
        [NSException raise:NSInvalidArgumentException format:@"Country code cannot be nil!"];
    }

    if ([countryCode length] != 2) {
        [NSException raise:NSInvalidArgumentException format:@"Country code must be from two letters!"];
    }
    
    NSString *fileName = @"ZipRegex";
    NSString *fileType = @"plist";

    NSBundle *bundle =  [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:fileName ofType:fileType];
    if (! path) {
        NSString *podBundlePath = [bundle pathForResource:@"APValidators" ofType:@"bundle"];
        NSBundle *podBundle = [NSBundle bundleWithPath:podBundlePath];
        path = [podBundle pathForResource:fileName ofType:fileType];
    }
    
    NSDictionary *regexTable = [[NSDictionary alloc] initWithContentsOfFile:path];
    return regexTable[countryCode];
}


@end