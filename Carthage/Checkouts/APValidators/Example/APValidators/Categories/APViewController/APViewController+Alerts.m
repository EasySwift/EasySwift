//
// Created by Nickolay Sheika on 4/15/16.
// Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import "APViewController+Alerts.h"



@implementation APViewController (Alerts)

- (void)presentValidationAlert:(BOOL)isFormValid
                 errorMessages:(NSArray *)errorMessages
{
    NSString *title = isFormValid ? @"Success" : @"Failure";

    NSMutableString *message = [NSMutableString string];
    if (isFormValid) {
        [message appendString:@"Success"];
    }
    else {
        for (NSString *errorMessage in errorMessages) {
            [message appendFormat:@"%@\n", errorMessage];
        }
    }

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:okAction];

    [self presentViewController:alertController animated:YES completion:nil];
}

@end