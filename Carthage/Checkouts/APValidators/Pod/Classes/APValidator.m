//
// Created by Nickolay Sheika on 25.11.15.
// Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "APValidator.h"

NSString *const APValidatorStateChangedNotification = @"APValidatorStateChangedNotification";



@interface APValidator ()

@property(nonatomic, assign, getter=isValid, readwrite) BOOL valid;
@end



@implementation APValidator


#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        _valid = YES;
    }
    return self;
}

#pragma mark - Accessors

- (void)setErrorMessage:(NSString *)errorMessage
{
    _errorMessage = NSLocalizedString([errorMessage copy], nil);
}

- (void)setValid:(BOOL)valid
{
    if (_valid == valid) {
        return;
    }

    if ([self.delegate respondsToSelector:@selector(validatorWillChangeState:)]) {
        [self.delegate validatorWillChangeState:self];
    }

    _valid = valid;

    if (self.validatorStateChangedHandler) {
        self.validatorStateChangedHandler(self);
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:APValidatorStateChangedNotification
                                                        object:self];

    if ([self.delegate respondsToSelector:@selector(validatorDidChangeState:)]) {
        [self.delegate validatorDidChangeState:self];
    }
}

#pragma mark - Abstract

- (void)validate
{
    // abstract
}

#pragma mark - Description

- (NSString *)description
{
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@ - %@:  ", NSStringFromClass([self class]), [super description]];
    [description appendFormat:@"State = %@;  ", self.isValid ? @"Valid" : @"Not Valid"];
    [description appendFormat:@"Object = %@;", self.validationObject ? self.validationObject : @"Nil"];
    [description appendString:@">"];
    return description;
}


@end