//
// Created by Nickolay Sheika on 25.11.15.
// Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "APRegexValidator.h"
#import "APValidator+SubclassesOnly.h"
#import "NSPredicate+APValidators.h"



@implementation APRegexValidator


- (void)validate
{
    if (! self.regex) {
        [NSException raise:NSInvalidArgumentException format:@"Regex validator should have regex before validation!"];
    }

    NSPredicate *predicate = [NSPredicate predicateWithRegex:self.regex];
    self.valid = [predicate evaluateWithObject:self.validationObject];
}


@end