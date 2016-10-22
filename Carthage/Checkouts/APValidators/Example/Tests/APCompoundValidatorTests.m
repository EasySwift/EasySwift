//
//  APCompoundValidatorTests.m
//  APValidators
//
//  Created by Nickolay Sheika on 4/18/16.
//  Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import "APCompoundValidator.h"
#import "APValidator+SubclassesOnly.h"



@interface APCompoundValidatorTests : XCTestCase


@property(nonatomic, strong) APCompoundValidator *validator;
@end



@implementation APCompoundValidatorTests


- (void)setUp
{
    [super setUp];

    self.validator = [APCompoundValidator new];
}

#pragma mark - Tests

- (void)testValidate_ValidatesEveryValidator
{
    // given
    id validatorMock = [OCMockObject niceMockForClass:[APValidator class]];
    self.validator.validators = @[ validatorMock ];

    // stubs and mocks
    [[validatorMock expect] validate];

    // call
    [self.validator validate];

    // expectations
    [validatorMock verify];
}

- (void)testValidate_ValidIfAllValidatorsAreValid
{
    // given
    APValidator *validator1 = [APValidator new];
    APValidator *validator2 = [APValidator new];
    self.validator.validators = @[ validator1, validator2 ];

    // call
    validator1.valid = YES;
    validator2.valid = YES;

    // expectations
    expect(self.validator.isValid).to.beTruthy();
}

- (void)testValidate_NotValidIfAnyValidatorIsInvalid
{
    // given
    APValidator *validator1 = [APValidator new];
    APValidator *validator2 = [APValidator new];
    self.validator.validators = @[ validator1, validator2 ];

    // call
    validator1.valid = YES;
    validator2.valid = NO;

    // expectations
    expect(self.validator.isValid).to.beFalsy();
}

- (void)testValidationObjectGoesToAllValidators
{
    // given
    NSString *validationObject = @"1488";
    APValidator *validator1 = [APValidator new];
    APValidator *validator2 = [APValidator new];
    self.validator.validators = @[ validator1, validator2 ];

    // call
    self.validator.validationObject = validationObject;

    // expectations
    expect(validator1.validationObject).to.equal(validationObject);
    expect(validator2.validationObject).to.equal(validationObject);
}

- (void)testCompoundErrorMessages
{
    // given
    APValidator *validator1 = [APValidator new];
    validator1.errorMessage = @"1";
    APValidator *validator2 = [APValidator new];
    validator2.errorMessage = @"2";
    APValidator *validator3 = [APValidator new];
    validator3.errorMessage = @"3";
    self.validator.validators = @[ validator1, validator2, validator3 ];

    // call
    validator1.valid = NO;
    validator2.valid = YES;
    validator3.valid = NO;

    // expectations
    expect(self.validator.errorMessages).to.haveCount(2);
    expect(self.validator.errorMessages[0]).to.equal(@"1");
    expect(self.validator.errorMessages[1]).to.equal(@"3");
    expect(self.validator.errorMessage).to.equal(@"1");
}

@end
