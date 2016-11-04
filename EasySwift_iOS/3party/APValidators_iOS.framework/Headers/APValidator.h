//
// Created by Nickolay Sheika on 25.11.15.
// Copyright (c) 2015 Alterplay. All rights reserved.
//

#import <Foundation/Foundation.h>

@class APValidator;

typedef void (^APValidatorStateChangeHandler)(APValidator *validator);


/**
 * Notification
 * Will be send on every state change
 */
extern NSString *const APValidatorStateChangedNotification;



@protocol APDataValidatorDelegate <NSObject>


@optional

/**
 *  Invoked just before state change
 */
- (void)validatorWillChangeState:(APValidator *)validator;

/**
 * Invoked right after state change
 */
- (void)validatorDidChangeState:(APValidator *)validator;

@end



@interface APValidator : NSObject


/**
 *  Back link to control
 *  Currently supports only UITextField and UITextView
 */
@property(nonatomic, weak) id control;

/**
 *  Object for validation
 */
@property(nonatomic, strong) id validationObject;

/**
 *  Error message for invalid state, wrapped in LocalizedString under the hood
 */
@property(nonatomic, copy) IBInspectable NSString *errorMessage;

/**
 *  Delegate
 */
@property(nonatomic, weak) IBOutlet id <APDataValidatorDelegate> delegate;

/**
 * Block that will be invoked on every state change
 */
@property(copy, nonatomic) APValidatorStateChangeHandler validatorStateChangedHandler;

/**
 *  Current validation state
 */
@property(nonatomic, assign, getter=isValid, readonly) BOOL valid;

/**
 *  Will validate current validation object and call all notifications
 */
- (void)validate;

@end