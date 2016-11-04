//
// Created by Nickolay Sheika on 3/15/16.
// Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import <UIKit/UIKit.h>

@class APValidator;



@interface UITextView (APValidators)

/**
 *  Validator object currently attached to this text view.
 */
@property(nonatomic, strong) IBOutlet APValidator *validator;

@end
