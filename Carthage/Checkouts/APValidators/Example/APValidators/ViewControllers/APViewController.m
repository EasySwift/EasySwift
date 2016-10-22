//
//  APViewController.m
//  APValidators
//
//  Created by Nickolay Sheika on 03/14/2016.
//  Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import "APViewController.h"
#import "APCompoundValidator.h"
#import "APViewController+Alerts.h"



@interface APViewController ()


@property(strong, nonatomic) IBOutlet APCompoundValidator *formValidator;

@end



@implementation APViewController

#pragma mark - Actions

- (IBAction)goButtonTap:(id)sender
{
    [self.formValidator validate];
    [self presentValidationAlert:self.formValidator.isValid errorMessages:self.formValidator.errorMessages];
}

@end
