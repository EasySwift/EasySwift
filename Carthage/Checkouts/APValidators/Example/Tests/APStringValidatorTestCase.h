//
//  APStringValidatorTestCase.h
//  APValidators
//
//  Created by Nickolay Sheika on 4/18/16.
//  Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import <XCTest/XCTest.h>

@class APStringValidator;



@interface APStringValidatorTestCase : XCTestCase


#pragma mark - SUT
@property(nonatomic, strong) APStringValidator *validator;

@end