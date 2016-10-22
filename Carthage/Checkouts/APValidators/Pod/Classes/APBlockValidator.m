//
// Created by Nickolay Sheika on 3/15/16.
// Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import "APBlockValidator.h"
#import "APValidator+SubclassesOnly.h"



@implementation APBlockValidator


- (void)validate
{
    [super validate];

    self.valid = self.validationBlock ? self.validationBlock(self.validationObject) : YES;
}


@end