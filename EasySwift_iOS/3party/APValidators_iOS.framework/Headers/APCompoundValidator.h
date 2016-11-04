//
// Created by Nickolay Sheika on 25.11.15.
// Copyright (c) 2015 Alterplay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APValidator.h"



@interface APCompoundValidator : APValidator


/**
 *  Array of child validators.
 */
@property(nonatomic, strong) IBOutletCollection(APValidator) NSArray *validators;

/**
 *  Compound error messages array of all currently not valid child validators.
 */
@property(nonatomic, strong, readonly) NSArray *errorMessages;

/**
 *  Return error message of first invalid child validator.
 */
@property(nonatomic, copy) NSString *errorMessage;

@end
