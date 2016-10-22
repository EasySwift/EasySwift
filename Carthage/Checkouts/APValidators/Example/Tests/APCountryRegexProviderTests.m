//
//  APCountryRegexProviderTests.m
//  APValidators
//
//  Created by Nickolay Sheika on 4/13/16.
//  Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//


#import "APCountryRegexProvider.h"



@interface APCountryRegexProviderTests : XCTestCase

@end



@implementation APCountryRegexProviderTests

- (void)testThrowsExceptionWhenCountryCodeIsNil
{
    expect(^{
        [APCountryRegexProvider regexForCountryWithCode:nil];
    }).to.raiseAny();
}

- (void)testThrowsExceptionWhenCountryCodeIsLongerThanTwoLetters
{
    expect(^{
        [APCountryRegexProvider regexForCountryWithCode:@"USA"];
    }).to.raiseAny();
}

- (void)testThrowsExceptionWhenCountryCodeIsShorterThanTwoLetters
{
    expect(^{
        [APCountryRegexProvider regexForCountryWithCode:@"U"];
    }).to.raiseAny();
}

- (void)testReturnsValidRegex_CA
{
    NSString *result = [APCountryRegexProvider regexForCountryWithCode:@"CA"];
    expect(result).to.equal(@"^([ABCEGHJKLMNPRSTVXY]\\d[ABCEGHJKLMNPRSTVWXYZ]) ?(\\d[ABCEGHJKLMNPRSTVWXYZ]\\d)$");
}

- (void)testReturnsValidRegex_LB
{
    NSString *result = [APCountryRegexProvider regexForCountryWithCode:@"LB"];
    expect(result).to.equal(@"^(\\d{4}(\\d{4})?)$");
}

- (void)testReturnsValidRegex_RE
{
    NSString *result = [APCountryRegexProvider regexForCountryWithCode:@"RE"];
    expect(result).to.equal(@"^((97|98)(4|7|8)\\d{2})$");
}

- (void)testReturnsNilForNotSupportedCountryCode
{
    NSString *result = [APCountryRegexProvider regexForCountryWithCode:@"TX"];
    expect(result).to.beNil();
}

@end
