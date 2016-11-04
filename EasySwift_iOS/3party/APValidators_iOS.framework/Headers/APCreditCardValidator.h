//
// Created by Nickolay Sheika on 05.12.15.
// Copyright (c) 2015 Alterplay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APStringValidator.h"


typedef NS_ENUM(NSInteger, APCreditCardType) {
    APCreditCardTypeAmex,
    APCreditCardTypeVisa,
    APCreditCardTypeMastercard,
    APCreditCardTypeDiscover,
    APCreditCardTypeDinersClub,
    APCreditCardTypeJCB,
    APCreditCardTypeUnsupported,
    APCreditCardTypeInvalid
};

@interface APCreditCardValidator : APStringValidator

/**
 *  Returns card type for current validationObject
 */
@property(nonatomic, assign, readonly) APCreditCardType creditCardType;

@end