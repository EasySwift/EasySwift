//
// Created by Nickolay Sheika on 05.12.15.
// Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "APEmailValidator.h"
#import "APValidator+SubclassesOnly.h"
#import "NSPredicate+APValidators.h"



@implementation APEmailValidator


NSString *const APEmailValidatorRegex = @"^[_A-Za-z0-9-+]+(\\.[_A-Za-z0-9-+]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z‌​]{2,4})$";

- (void)validate
{
    [super validate];

    NSPredicate *predicate = [NSPredicate predicateWithRegex:APEmailValidatorRegex];
    self.valid = [predicate evaluateWithObject:self.validationObject];
}

@end