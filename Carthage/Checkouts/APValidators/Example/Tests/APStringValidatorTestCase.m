//
//  APStringValidatorTestCase.m
//  APValidators
//
//  Created by Nickolay Sheika on 4/18/16.
//  Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import "APStringValidatorTestCase.h"
#import "APStringValidator.h"



@implementation APStringValidatorTestCase


- (void)setUp
{
    [super setUp];

    self.validator = [APStringValidator new];
}


- (void)testThrowsExceptionIfValidationObjectIsNotNSString
{
    self.validator.validationObject = @1488;

    expect(^{
        [self.validator validate];
    }).to.raiseAny();
}

@end
