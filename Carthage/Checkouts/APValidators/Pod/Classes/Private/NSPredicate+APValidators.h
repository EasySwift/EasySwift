//
// Created by Nickolay Sheika on 4/18/16.
// Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APCreditCardValidator.h"



@interface NSPredicate (APValidators)

+ (NSPredicate *)predicateWithRegex:(NSString *)regex;
+ (NSPredicate *)predicateForCreditCardType:(APCreditCardType)creditCardType;

@end