//
// Created by Nickolay Sheika on 4/12/16.
// Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APValidator.h"
#import "APStringValidator.h"



@interface APZipValidator : APStringValidator

/**
 *  Country code from 2 chars.
 */
@property(nonatomic, copy) IBInspectable NSString *countryCode;

@end