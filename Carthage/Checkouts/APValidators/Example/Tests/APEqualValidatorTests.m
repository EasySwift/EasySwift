//
//  APEqualValidatorTests.m
//  APValidators
//
//  Created by Nickolay Sheika on 4/18/16.
//  Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//


#import "APEqualStringValidator.h"
#import "APStringValidatorTestCase.h"



@interface APEqualStringValidatorTests : APStringValidatorTestCase


#pragma mark - SUT
@property(nonatomic, strong) APEqualStringValidator *equalStringValidator;
@end



@implementation APEqualStringValidatorTests


- (void)setUp
{
    [super setUp];

    self.validator = [APEqualStringValidator new];
    self.equalStringValidator = (APEqualStringValidator *) self.validator;
}

#pragma mark - Tests

- (void)testThrowsExceptionIfSecondControlIsNotSupported
{
    UIButton *button = [UIButton new];
    expect(^{
        self.equalStringValidator.secondControl = button;
    }).to.raiseAny();
}

- (void)testListensForTextFieldNotificationAndValidates_False
{
    // given
    UITextField *textField = [UITextField new];
    self.equalStringValidator.secondControl = textField;
    self.equalStringValidator.validationObject = @"1";
    textField.text = @"1488";

    // call
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:textField];

    // expectations
    expect(self.equalStringValidator.isValid).to.beFalsy();
}

- (void)testListensForTextFieldNotificationAndValidates_True
{
    // given
    UITextField *textField = [UITextField new];
    self.equalStringValidator.secondControl = textField;
    self.equalStringValidator.validationObject = @"1488";
    textField.text = @"1488";

    // call
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:textField];

    // expectations
    expect(self.equalStringValidator.isValid).to.beTruthy();
}

- (void)testListensForTextViewNotificationAndValidates_False
{
    // given
    UITextView *textView = [UITextView new];
    self.equalStringValidator.secondControl = textView;
    self.equalStringValidator.validationObject = @"1";
    textView.text = @"1488";

    // call
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:textView];

    // expectations
    expect(self.equalStringValidator.isValid).to.beFalsy();
}

- (void)testListensForTextViewNotificationAndValidates_True
{
    // given
    UITextView *textView = [UITextView new];
    self.equalStringValidator.secondControl = textView;
    self.equalStringValidator.validationObject = @"1488";
    textView.text = @"1488";

    // call
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:textView];

    // expectations
    expect(self.equalStringValidator.isValid).to.beTruthy();
}

@end
