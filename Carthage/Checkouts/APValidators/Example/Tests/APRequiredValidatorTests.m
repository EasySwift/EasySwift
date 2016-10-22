//
//  APRequiredValidatorTests.m
//  APValidators
//
//  Created by Nickolay Sheika on 4/18/16.
//  Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import "APStringValidatorTestCase.h"
#import "APRequiredValidator.h"



@interface APRequiredValidatorTests : APStringValidatorTestCase


#pragma mark - SUT
@property(nonatomic, strong) APRequiredValidator *requiredValidator;
@end



@implementation APRequiredValidatorTests


- (void)setUp
{
    [super setUp];

    self.validator = [APRequiredValidator new];
    self.requiredValidator = (APRequiredValidator *) self.validator;
}

#pragma mark - Tests

- (void)testValidation_True
{
    // call
    self.requiredValidator.validationObject = @"1";
    [self.requiredValidator validate];

    // expectations
    expect(self.requiredValidator.isValid).to.beTruthy();
}

- (void)testValidation_False
{
    // call
    self.requiredValidator.validationObject = @"";
    [self.requiredValidator validate];

    // expectations
    expect(self.requiredValidator.isValid).to.beFalsy();
}

- (void)testValidation_Nil
{
    // call
    self.requiredValidator.validationObject = nil;
    [self.requiredValidator validate];

    // expectations
    expect(self.requiredValidator.isValid).to.beFalsy();
}

@end
