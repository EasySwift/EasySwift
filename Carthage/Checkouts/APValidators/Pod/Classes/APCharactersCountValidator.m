//
// Created by Nickolay Sheika on 05.12.15.
// Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "APCharactersCountValidator.h"
#import "APValidator+SubclassesOnly.h"



@implementation APCharactersCountValidator


- (NSUInteger)minCount
{
    if (! _minCount) {
        _minCount = 0;
    }
    return _minCount;
}

- (NSUInteger)maxCount
{
    if (! _maxCount) {
        _maxCount = NSUIntegerMax;
    }
    return _maxCount;
}

- (void)validate
{
    [super validate];

    NSString *validationObject = self.validationObject;
    NSUInteger length = validationObject.length;

    BOOL moreThanMinCount = length >= self.minCount;
    BOOL lessThanMaxCount = length <= self.maxCount;

    self.valid = moreThanMinCount && lessThanMaxCount;
}


@end