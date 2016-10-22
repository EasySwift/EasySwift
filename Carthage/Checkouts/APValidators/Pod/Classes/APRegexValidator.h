//
// Created by Nickolay Sheika on 25.11.15.
// Copyright (c) 2015 Alterplay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APValidator.h"



@interface APRegexValidator : APValidator

/**
 *  Simply regex string for validation of validationObject.
 */
@property(nonatomic, copy) IBInspectable NSString *regex;


@end