//
// Created by Nickolay Sheika on 4/12/16.
// Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import "APZipValidator.h"
#import "APCountryRegexProvider.h"
#import "APValidator+SubclassesOnly.h"
#import "NSPredicate+APValidators.h"



@implementation APZipValidator

- (void)validate
{
    [super validate];

    NSString *regex = [APCountryRegexProvider regexForCountryWithCode:self.countryCode];

    if (! regex) {
        NSLog(@"WARNING : APZipValidator has unsupported country code. Will have invalid state.");
        self.valid = NO;
    }
    else {
        NSPredicate *predicate = [NSPredicate predicateWithRegex:regex];
        self.valid = [predicate evaluateWithObject:self.validationObject];
    }
}

@end