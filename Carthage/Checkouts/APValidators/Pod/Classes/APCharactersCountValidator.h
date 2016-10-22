//
// Created by Nickolay Sheika on 05.12.15.
// Copyright (c) 2015 Alterplay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APStringValidator.h"



@interface APCharactersCountValidator : APStringValidator

/**
 *  Minimum characters count in validationObject
 */
@property(nonatomic, assign) IBInspectable NSUInteger minCount;

/**
 *  Maximum characters count in validationObject
 */
@property(nonatomic, assign) IBInspectable NSUInteger maxCount;

@end