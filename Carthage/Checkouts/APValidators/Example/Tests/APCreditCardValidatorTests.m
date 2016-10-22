//
//  APCreditCardValidatorTests.m
//  APValidators
//
//  Created by Nickolay Sheika on 4/18/16.
//  Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import "APStringValidatorTestCase.h"
#import "APCreditCardValidator.h"



@interface APCreditCardValidatorTests : APStringValidatorTestCase


@property(nonatomic, strong) APCreditCardValidator *creditCardValidator;
@end



@implementation APCreditCardValidatorTests


- (void)setUp
{
    [super setUp];

    self.validator = [APCreditCardValidator new];
    self.creditCardValidator = (APCreditCardValidator *) self.validator;
}

#pragma mark - Tests

- (void)testEmptyValidationObject
{
    // given
    self.creditCardValidator.validationObject = nil;

    // call
    [self.creditCardValidator validate];

    // expectations
    expect(self.creditCardValidator.isValid).to.beFalsy();
    expect(self.creditCardValidator.creditCardType).to.equal(APCreditCardTypeInvalid);
}

- (void)testValidationObjectIsShorterThanNine
{
    // given
    self.creditCardValidator.validationObject = @"12345678";

    // call
    [self.creditCardValidator validate];

    // expectations
    expect(self.creditCardValidator.isValid).to.beFalsy();
    expect(self.creditCardValidator.creditCardType).to.equal(APCreditCardTypeInvalid);
}

- (void)testValidationObjectIsLongerThanNineteen
{
    // given
    self.creditCardValidator.validationObject = @"12345678909876543210";

    // call
    [self.creditCardValidator validate];

    // expectations
    expect(self.creditCardValidator.isValid).to.beFalsy();
    expect(self.creditCardValidator.creditCardType).to.equal(APCreditCardTypeInvalid);
}

- (void)testVISA
{
    // given
    self.creditCardValidator.validationObject = @"4012888888881881";

    // call
    [self.creditCardValidator validate];

    // expectations
    expect(self.creditCardValidator.isValid).to.beTruthy();
    expect(self.creditCardValidator.creditCardType).to.equal(APCreditCardTypeVisa);
}

- (void)testVISA_Short
{
    // given
    self.creditCardValidator.validationObject = @"4222222222222";

    // call
    [self.creditCardValidator validate];

    // verifications
    expect(self.creditCardValidator.isValid).to.beTruthy();
    expect(self.creditCardValidator.creditCardType).to.equal(APCreditCardTypeVisa);
}

- (void)testMasterCard
{
    // given
    self.creditCardValidator.validationObject = @"5555555555554444";

    // call
    [self.creditCardValidator validate];

    // expectations
    expect(self.creditCardValidator.isValid).to.beTruthy();
    expect(self.creditCardValidator.creditCardType).to.equal(APCreditCardTypeMastercard);
}

- (void)testAMEX
{
    // given
    self.creditCardValidator.validationObject = @"378282246310005";

    // call
    [self.creditCardValidator validate];

    // expectations
    expect(self.creditCardValidator.isValid).to.beTruthy();
    expect(self.creditCardValidator.creditCardType).to.equal(APCreditCardTypeAmex);
}

- (void)testDiscover
{
    // given
    self.creditCardValidator.validationObject = @"6011111111111117";

    // call
    [self.creditCardValidator validate];

    // expectations
    expect(self.creditCardValidator.isValid).to.beTruthy();
    expect(self.creditCardValidator.creditCardType).to.equal(APCreditCardTypeDiscover);
}

- (void)testDinersClub
{
    // given
    self.creditCardValidator.validationObject = @"30569309025904";

    // call
    [self.creditCardValidator validate];

    // expectations
    expect(self.creditCardValidator.isValid).to.beTruthy();
    expect(self.creditCardValidator.creditCardType).to.equal(APCreditCardTypeDinersClub);
}

- (void)testJCB
{
    // given
    self.creditCardValidator.validationObject = @"3566002020360505";

    // call
    [self.creditCardValidator validate];

    // expectations
    expect(self.creditCardValidator.isValid).to.beTruthy();
    expect(self.creditCardValidator.creditCardType).to.equal(APCreditCardTypeJCB);
}

- (void)testMaestro_19Digits
{
    // given
    self.creditCardValidator.validationObject = @"676123070691347787";

    // call
    [self.creditCardValidator validate];

    // expectations
    expect(self.creditCardValidator.isValid).to.beTruthy();
    expect(self.creditCardValidator.creditCardType).to.equal(APCreditCardTypeUnsupported);
}

- (void)testLaser_19Digits
{
    // given
    self.creditCardValidator.validationObject = @"6304219447607087665";

    // call
    [self.creditCardValidator validate];

    // expectations
    expect(self.creditCardValidator.isValid).to.beTruthy();
    expect(self.creditCardValidator.creditCardType).to.equal(APCreditCardTypeUnsupported);
}

- (void)testCreditCardTypeThrowsExceptionIfValidatonObjectIsNotNSString
{
    self.creditCardValidator.validationObject = @1488;

    expect(^{
        [self.creditCardValidator creditCardType];
    }).to.raiseAny();
}

@end
