//
// Created by Nickolay Sheika on 4/12/16.
// Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import "APIndicatorView.h"



@implementation APIndicatorView


#pragma mark - APDataValidatorDelegate

- (void)validatorDidChangeState:(APValidator *)validator
{
    self.backgroundColor = validator.isValid ? [UIColor greenColor] : [UIColor redColor];
}


@end