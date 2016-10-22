//
// Created by Nickolay Sheika on 25.11.15.
// Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "APCompoundValidator.h"
#import "APValidator+SubclassesOnly.h"



@implementation APCompoundValidator

@dynamic errorMessage;

#pragma mark - Lifecycle

- (void)dealloc
{
    [self.notificationCenter removeObserver:self];
}

#pragma mark - Accessors

- (NSNotificationCenter *)notificationCenter
{
    return [NSNotificationCenter defaultCenter];
}

- (void)setValidators:(NSArray *)validators
{
    _validators = validators;
    [self setupAllValidators];
}

- (void)setValidationObject:(id)validationObject
{
    [super setValidationObject:validationObject];
    [self setupAllValidators];
}

- (NSArray *)errorMessages
{
    NSMutableArray *result = [NSMutableArray array];
    for (APValidator *validator in self.validators) {
        if (! validator.isValid && validator.errorMessage) {
            [result addObject:validator.errorMessage];
        }
    }
    return [result copy];
}

- (NSString *)errorMessage
{
    return [self.errorMessages count] > 0 ? self.errorMessages[0] : nil;
}

#pragma mark - Overriden

- (void)validate
{
    [self.validators makeObjectsPerformSelector:@selector(validate)];
}

- (void)checkAllValidatorsAndUpdateState
{
    BOOL valid = YES;

    for (APValidator *validator in self.validators) {
        if (! validator.isValid) {
            valid = NO;
            break;
        }
    }

    self.valid = valid;
}

#pragma mark - Private

- (void)setupAllValidators
{
    [self.notificationCenter removeObserver:self];

    for (APValidator *validator in self.validators) {
        validator.validationObject = self.validationObject;
        [self.notificationCenter addObserver:self
                                    selector:@selector(oneOfValidatorsChangedState:)
                                        name:APValidatorStateChangedNotification
                                      object:validator];
    }
}

#pragma mark - Notifications

- (void)oneOfValidatorsChangedState:(NSNotification *)notification
{
    [self validate];
    [self checkAllValidatorsAndUpdateState];
}

@end