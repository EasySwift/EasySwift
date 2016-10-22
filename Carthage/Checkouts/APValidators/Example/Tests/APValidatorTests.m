//
//  APValidatorTests.m
//  APValidators
//
//  Created by Nickolay Sheika on 4/18/16.
//  Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//


#import "APValidator.h"
#import "APValidator+SubclassesOnly.h"



@interface APValidatorTests : XCTestCase


@property(nonatomic, strong) APValidator *validator;
@end



@implementation APValidatorTests


- (void)setUp
{
    [super setUp];

    self.validator = [APValidator new];
}

#pragma mark - Tests

- (void)testStartsWithValidState
{
    expect(self.validator.isValid).to.beTruthy();
}

- (void)testNothingHappensIfStateNotChanges_True
{
    expect(^{
        self.validator.valid = YES;
    }).toNot.notify(APValidatorStateChangedNotification);
}

- (void)testNothingHappensIfStateNotChanges_False
{
    self.validator.valid = NO;
    expect(^{
        self.validator.valid = NO;
    }).toNot.notify(APValidatorStateChangedNotification);
}

- (void)testNotifiesDelegateOnStateChange
{
    // given
    id mockValidatorDelegate = [OCMockObject mockForProtocol:@protocol(APDataValidatorDelegate)];
    [mockValidatorDelegate setExpectationOrderMatters:YES];
    self.validator.delegate = mockValidatorDelegate;

    // stubs and mocks
    [[mockValidatorDelegate expect] validatorWillChangeState:self.validator];
    [[mockValidatorDelegate expect] validatorDidChangeState:self.validator];

    // call
    self.validator.valid = NO;

    // expectations
    [mockValidatorDelegate verify];
}

- (void)testCallsBlockOnStateChange
{
    // given
    __block BOOL result = NO;
    self.validator.validatorStateChangedHandler = ^(APValidator *validator) {
        result = YES;
    };

    // call
    self.validator.valid = NO;

    // expectations
    expect(result).to.beTruthy();
}

- (void)testPostsNotificationOnStateChange
{
    expect(^{
        self.validator.valid = NO;
    }).to.notify(APValidatorStateChangedNotification);
}

- (void)testReturnsDescription
{
    expect(self.validator.description).toNot.beNil();
}

@end
