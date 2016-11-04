//
// Created by Nickolay Sheika on 4/13/16.
// Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface APCountryRegexProvider : NSObject

+ (NSString *)regexForCountryWithCode:(NSString *)countryCode;

@end