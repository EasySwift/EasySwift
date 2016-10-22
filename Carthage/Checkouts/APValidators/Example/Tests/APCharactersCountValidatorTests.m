//
//  APCharactersCountValidatorTests.m
//  APValidators
//
//  Created by Nickolay Sheika on 4/18/16.
//  Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//



#import "APStringValidatorTestCase.h"
#import "APCharactersCountValidator.h"



@interface APCharactersCountValidatorTests : APStringValidatorTestCase


@property(nonatomic, strong) APCharactersCountValidator *charactersCountValidator;
@end



@implementation APCharactersCountValidatorTests


- (void)setUp
{
    [super setUp];

    self.validator = [APCharactersCountValidator new];
    self.charactersCountValidator = (APCharactersCountValidator *) self.validator;
}

- (void)testDefaults
{
    // expectations
    expect(self.charactersCountValidator.minCount).to.equal(0);
    expect(self.charactersCountValidator.maxCount).to.equal(NSUIntegerMax);
}

- (void)testValidationWithDefaults
{
    // given
    self.charactersCountValidator.validationObject = @"1488";

    // call
    [self.charactersCountValidator validate];

    // expectations
    expect(self.charactersCountValidator.isValid).to.beTruthy();
}

- (void)testValidationWithMinCountDefault_True
{
    // given
    self.charactersCountValidator.maxCount = 5;
    self.charactersCountValidator.validationObject = @"1488";

    // call
    [self.charactersCountValidator validate];

    // expectations
    expect(self.charactersCountValidator.isValid).to.beTruthy();
}

- (void)testValidationWithMinCountDefault_False
{
    // given
    self.charactersCountValidator.maxCount = 3;
    self.charactersCountValidator.validationObject = @"1488";

    // call
    [self.charactersCountValidator validate];

    // expectations
    expect(self.charactersCountValidator.isValid).to.beFalsy();
}

- (void)testValidationWithMaxCountDefault_True
{
    // given
    self.charactersCountValidator.minCount = 1;
    self.charactersCountValidator.validationObject = @"1488";

    // call
    [self.charactersCountValidator validate];

    // expectations
    expect(self.charactersCountValidator.isValid).to.beTruthy();
}

- (void)testValidationWithMaxCountDefault_False
{
    // given
    self.charactersCountValidator.minCount = 5;
    self.charactersCountValidator.validationObject = @"1488";

    // call
    [self.charactersCountValidator validate];

    // expectations
    expect(self.charactersCountValidator.isValid).to.beFalsy();
}

@end
