//
// Created by Nickolay Sheika on 05.12.15.
// Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "APCreditCardValidator.h"
#import "APValidator+SubclassesOnly.h"
#import "NSPredicate+APValidators.h"



@implementation APCreditCardValidator


- (APCreditCardType)creditCardType
{
    if (! self.validationObject || ! self.isValid) {
        return APCreditCardTypeInvalid;
    }

    NSString *validationString = nil;

    if (! [self.validationObject isKindOfClass:[NSString class]]) {
        [NSException raise:NSInternalInconsistencyException
                    format:@"%@ validationObject should be NSString!",
                           NSStringFromClass([self class])];
    }
    else {
        validationString = self.validationObject;
    }

    APCreditCardType type = APCreditCardTypeUnsupported;
    for (int i = 0; i < APCreditCardTypeUnsupported; ++ i) {
        NSPredicate *predicate = [NSPredicate predicateForCreditCardType:(APCreditCardType) i];
        BOOL result = [predicate evaluateWithObject:validationString];
        if (result) {
            type = (APCreditCardType) i;
            break;
        }
    }

    return type;
}

- (void)validate
{
    [super validate];

    NSString *validationString = self.validationObject;

    if (! validationString || validationString.length < 9 || validationString.length > 19) {
        self.valid = NO;
        return;
    }

    NSMutableString *reversedString = [NSMutableString stringWithCapacity:[validationString length]];

    [validationString enumerateSubstringsInRange:NSMakeRange(0, [validationString length])
                                        options:(NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences)
                                     usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                         [reversedString appendString:substring];
                                     }];

    NSUInteger oddSum = 0, evenSum = 0;

    for (NSUInteger i = 0; i < [reversedString length]; i ++) {
        NSInteger digit = [[NSString stringWithFormat:@"%C", [reversedString characterAtIndex:i]] integerValue];

        if (i % 2 == 0) {
            evenSum += digit;
        }
        else {
            oddSum += digit / 5 + (2 * digit) % 10;
        }
    }
    self.valid = (oddSum + evenSum) % 10 == 0;
}


@end