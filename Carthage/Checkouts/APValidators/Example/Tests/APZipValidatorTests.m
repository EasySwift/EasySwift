//
//  APZipValidatorTests.m
//  APValidators
//
//  Created by Nickolay Sheika on 4/15/16.
//  Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//



#import "APZipValidator.h"
#import "APCountryRegexProvider.h"
#import "APStringValidatorTestCase.h"
#import "NSPredicate+APValidators.h"



@interface APZipValidatorTests : APStringValidatorTestCase


#pragma mark - SUT
@property(nonatomic, strong) APZipValidator *zipValidator;

#pragma mark - Mocks
@property(nonatomic, strong) id regexProviderMock;
@end



@implementation APZipValidatorTests


- (void)setUp
{
    [super setUp];

    self.regexProviderMock = [OCMockObject niceMockForClass:[APCountryRegexProvider class]];

    self.validator = [APZipValidator new];
    self.zipValidator = (APZipValidator *) self.validator;
}

#pragma mark - Tests

- (void)testTakesRegexFromProvider
{
    // given
    NSString *countryCode = @"UA";

    // stubs and mocks
    [[self.regexProviderMock expect] regexForCountryWithCode:countryCode];

    // call
    self.zipValidator.countryCode = countryCode;
    [self.zipValidator validate];

    // expectations
    [self.regexProviderMock verify];
}

- (void)testNotValidForNotSupportedCountryCode
{
    // given
    NSString *countryCode = @"Test";

    // stubs and mocks
    [[[self.regexProviderMock stub] andReturn:nil] regexForCountryWithCode:countryCode];

    // call
    self.zipValidator.countryCode = countryCode;
    [self.zipValidator validate];

    // expectations
    expect(self.zipValidator.isValid).to.beFalsy();
}

- (void)testValidatesOverProperRegex_True
{
    // given
    NSString *countryCode = @"Test";
    NSString *regex = @"1";

    // stubs and mocks
    [[[self.regexProviderMock stub] andReturn:regex] regexForCountryWithCode:countryCode];

    // call
    self.zipValidator.countryCode = countryCode;
    self.zipValidator.validationObject = @"1";
    [self.zipValidator validate];

    // expectations
    expect(self.zipValidator.isValid).to.beTruthy();
}

- (void)testValidatesOverProperRegex_False
{
    // given
    NSString *countryCode = @"Test";
    NSString *regex = @"1";

    // stubs and mocks
    [[[self.regexProviderMock stub] andReturn:regex] regexForCountryWithCode:countryCode];

    // call
    self.zipValidator.countryCode = countryCode;
    self.zipValidator.validationObject = @"1488";
    [self.zipValidator validate];

    // expectations
    expect(self.zipValidator.isValid).to.beFalsy();
}

@end
