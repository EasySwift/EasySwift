//
// Created by Nickolay Sheika on 4/18/16.
// Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import "NSPredicate+APValidators.h"



@implementation NSPredicate (APValidators)


+ (NSPredicate *)predicateWithRegex:(NSString *)regex
{
    return [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
}

+ (NSPredicate *)predicateForCreditCardType:(APCreditCardType)creditCardType
{
    NSString *regex = nil;
    switch (creditCardType) {
        case APCreditCardTypeAmex:
            regex = @"^3[47][0-9]{5,}$";
            break;
        case APCreditCardTypeVisa:
            regex = @"^4[0-9]{6,}$";
            break;
        case APCreditCardTypeMastercard:
            regex = @"^5[1-5][0-9]{5,}$";
            break;
        case APCreditCardTypeDiscover:
            regex = @"^6(?:011|5[0-9]{2})[0-9]{3,}$";
            break;
        case APCreditCardTypeDinersClub:
            regex = @"^3(?:0[0-5]|[68][0-9])[0-9]{4,}$";
            break;
        case APCreditCardTypeJCB:
            regex = @"^(?:2131|1800|35[0-9]{3})[0-9]{3,}$";
            break;
        case APCreditCardTypeUnsupported:
        case APCreditCardTypeInvalid:
        default:
            return nil;
    }

    return [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
}


@end