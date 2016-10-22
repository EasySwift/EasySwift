//
//  APBlockValidatorTests.m
//  APValidators
//
//  Created by Nickolay Sheika on 4/18/16.
//  Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//


#import "APBlockValidator.h"



@interface APBlockValidatorTests : XCTestCase


#pragma mark - SUT
@property(nonatomic, strong) APBlockValidator *validator;
@end



@implementation APBlockValidatorTests


- (void)setUp
{
    [super setUp];

    self.validator = [APBlockValidator new];
}

#pragma mark - Tests

- (void)testInvokesBlockDuringValidation_True
{
    // given
    self.validator.validationBlock = ^BOOL(id validationObject) {
        return YES;
    };

    // call
    [self.validator validate];

    // expectations
    expect(self.validator.isValid).to.beTruthy();
}

- (void)testInvokesBlockDuringValidation_False
{
    // given
    self.validator.validationBlock = ^BOOL(id validationObject) {
        return NO;
    };

    // call
    [self.validator validate];

    // expectations
    expect(self.validator.isValid).to.beFalsy();
}

- (void)testNilBlock
{
    // given
    self.validator.validationBlock = nil;

    // call
    [self.validator validate];

    // expectations
    expect(self.validator.isValid).to.beTruthy();
}

@end
