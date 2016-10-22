//
//  APRegexValidatorTests.m
//  APValidators
//
//  Created by Nickolay Sheika on 4/18/16.
//  Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//




#import "APRegexValidator.h"



@interface APRegexValidatorTests : XCTestCase


#pragma mark - SUT
@property(nonatomic, strong) APRegexValidator *regexValidator;
@end



@implementation APRegexValidatorTests


- (void)setUp
{
    [super setUp];

    self.regexValidator = [APRegexValidator new];
}

#pragma mark - Tests

- (void)testThrowsExceptionWithNilRegex
{
    expect(^{
        [self.regexValidator validate];
    }).to.raiseAny();
}

- (void)testValidation_True
{
    // given
    NSString *regex = @"1";

    // call
    self.regexValidator.regex = regex;
    self.regexValidator.validationObject = @"1";
    [self.regexValidator validate];

    // expectations
    expect(self.regexValidator.isValid).to.beTruthy();
}

- (void)testValidation_False
{
    // given
    NSString *regex = @"1";

    // call
    self.regexValidator.regex = regex;
    self.regexValidator.validationObject = @"1488";
    [self.regexValidator validate];

    // expectations
    expect(self.regexValidator.isValid).to.beFalsy();
}

@end
