//
// Created by Nickolay Sheika on 3/16/16.
// Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APStringValidator.h"



@interface APEqualStringValidator : APStringValidator

/**
 *  Second control. Currently supports UITextField and UITextView. Will throw exception for another classes.
 */
@property(nonatomic, weak) IBOutlet id secondControl;

@end
