//
//  APEmailValidatorTests.m
//  APValidators
//
//  Created by Nickolay Sheika on 4/18/16.
//  Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import "APStringValidatorTestCase.h"
#import "APEmailValidator.h"



@interface APEmailValidatorTests : APStringValidatorTestCase


@property(nonatomic, strong) APEmailValidator *emailValidator;
@end



@implementation APEmailValidatorTests


- (void)setUp
{
    [super setUp];

    self.validator = [APEmailValidator new];
    self.emailValidator = (APEmailValidator *) self.validator;
}

#pragma mark - Tests

- (void)testValidation_ValidEmail
{
    // given
    NSString *email = @"test@mail.ru";

    // call
    self.emailValidator.validationObject = email;
    [self.emailValidator validate];

    // expectations
    expect(self.emailValidator.isValid).to.beTruthy();
}

- (void)testValidation_NotValidEmail
{
    // given
    NSString *email = @"test";

    // call
    self.emailValidator.validationObject = email;
    [self.emailValidator validate];

    // expectations
    expect(self.emailValidator.isValid).to.beFalsy();
}

- (void)testValidation_NotValidEmail2
{
    // given
    NSString *email = @"test@mailru";

    // call
    self.emailValidator.validationObject = email;
    [self.emailValidator validate];

    // expectations
    expect(self.emailValidator.isValid).to.beFalsy();
}

@end
