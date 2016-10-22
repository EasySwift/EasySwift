//
// Created by Nickolay Sheika on 3/15/16.
// Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import "APRequiredValidator.h"
#import "APValidator+SubclassesOnly.h"


@implementation APRequiredValidator


- (void)validate
{
    [super validate];

    NSString *validationString = self.validationObject;
    self.valid = [validationString length] > 0;
}


@end