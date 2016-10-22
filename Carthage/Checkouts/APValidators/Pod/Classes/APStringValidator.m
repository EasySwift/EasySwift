//
// Created by Nickolay Sheika on 4/18/16.
// Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import "APStringValidator.h"



@implementation APStringValidator


- (void)validate
{
    [super validate];

    if (self.validationObject && ! [self.validationObject isKindOfClass:[NSString class]]) {
        [NSException raise:NSInternalInconsistencyException
                    format:@"%@ validationObject should be NSString!",
                           NSStringFromClass([self class])];
    }
}


@end