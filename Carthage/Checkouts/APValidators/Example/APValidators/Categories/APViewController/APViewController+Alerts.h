//
// Created by Nickolay Sheika on 4/15/16.
// Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APViewController.h"



@interface APViewController (Alerts)


- (void)presentValidationAlert:(BOOL)isFormValid
                 errorMessages:(NSArray *)errorMessages;
@end