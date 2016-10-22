//
//  APValidatorsUITextViewTests.m
//  APValidators
//
//  Created by Nickolay Sheika on 4/18/16.
//  Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//


#import "APValidator.h"
#import "UITextView+APValidators.h"



@interface APValidatorsUITextViewTests : XCTestCase


#pragma mark - SUT
@property(nonatomic, strong) UITextView *textView;

#pragma mark - Mocks
@property(nonatomic, strong) id mockValidator;
@end



@implementation APValidatorsUITextViewTests


- (void)setUp
{
    [super setUp];

    self.mockValidator = [OCMockObject niceMockForClass:[APValidator class]];

    self.textView = [UITextView new];
    self.textView.text = @"1488";
}

#pragma mark - Tests

- (void)testValidatorAttach
{
    // stubs and mocks
    [[self.mockValidator expect] setControl:self.textView];
    [[self.mockValidator expect] setValidationObject:self.textView.text];

    // call
    self.textView.validator = self.mockValidator;

    // expectations
    [self.mockValidator verify];
}

- (void)testValidatesWhenTextViewTextChangesFromUI
{
    // given
    self.textView.validator = self.mockValidator;

    // stubs and mocks
    [[self.mockValidator expect] setValidationObject:@"1488"];
    [[self.mockValidator expect] validate];

    // call
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];

    // expectations
    [self.mockValidator verify];
}

- (void)testValidatesWhenTextViewTextChangesFromCode
{
    // given
    self.textView.validator = self.mockValidator;

    // stubs and mocks
    [[self.mockValidator expect] setValidationObject:@"1111"];
    [[self.mockValidator expect] validate];

    // call
    self.textView.text = @"1111";

    // expectations
    [self.mockValidator verify];
}

@end
