//
//  APValidatorsUITextFieldTests.m
//  APValidators
//
//  Created by Nickolay Sheika on 4/18/16.
//  Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//



#import "APValidator.h"
#import "UITextField+APValidators.h"


@interface APValidatorsUITextFieldTests : XCTestCase


#pragma mark - SUT
@property(nonatomic, strong) UITextField *textField;

#pragma mark - Mocks
@property(nonatomic, strong) id mockValidator;
@end



@implementation APValidatorsUITextFieldTests


- (void)setUp
{
    [super setUp];

    self.mockValidator = [OCMockObject niceMockForClass:[APValidator class]];

    self.textField = [UITextField new];
    self.textField.text = @"1488";
}

#pragma mark - Tests

- (void)testValidatorAttach
{
    // stubs and mocks
    [[self.mockValidator expect] setControl:self.textField];
    [[self.mockValidator expect] setValidationObject:self.textField.text];

    // call
    self.textField.validator = self.mockValidator;

    // expectations
    [self.mockValidator verify];
}

- (void)testValidatesWhenTextFieldTextChangesFromUI
{
    // given
    self.textField.validator = self.mockValidator;

    // stubs and mocks
    [[self.mockValidator expect] setValidationObject:@"1488"];
    [[self.mockValidator expect] validate];

    // call
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textField];

    // expectations
    [self.mockValidator verify];
}

- (void)testValidatesWhenTextFieldTextChangesFromCode
{
    // given
    self.textField.validator = self.mockValidator;

    // stubs and mocks
    [[self.mockValidator expect] setValidationObject:@"1111"];
    [[self.mockValidator expect] validate];

    // call
    self.textField.text = @"1111";

    // expectations
    [self.mockValidator verify];
}


@end
