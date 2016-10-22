//
// Created by Nickolay Sheika on 3/16/16.
// Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import "APEqualStringValidator.h"
#import "APValidator+SubclassesOnly.h"


@implementation APEqualStringValidator


#pragma mark - Accessors

- (void)setSecondControl:(id)secondControl
{
    BOOL controlIsTextField = [secondControl isKindOfClass:[UITextField class]];
    BOOL controlIsTextView = [secondControl isKindOfClass:[UITextView class]];

    if (! controlIsTextField && ! controlIsTextView) {
        [NSException raise:NSInternalInconsistencyException
                    format:@"APValidators currently support only UITextField and UITextView controls."];
    }

    if ([secondControl isEqual:_secondControl]) {
        return;
    }

    _secondControl = secondControl;

    [self.notificationCenter removeObserver:self];

    if (controlIsTextField) {
        [self.notificationCenter addObserver:self
                                    selector:@selector(ap_textFieldDidChange:)
                                        name:UITextFieldTextDidChangeNotification
                                      object:secondControl];
    }

    if (controlIsTextView) {
        [self.notificationCenter addObserver:self
                                    selector:@selector(ap_textViewDidChange:)
                                        name:UITextViewTextDidChangeNotification
                                      object:secondControl];
    }
}

- (NSNotificationCenter *)notificationCenter
{
    return [NSNotificationCenter defaultCenter];
}

#pragma mark - Lifecycle

- (void)dealloc
{
    [self.notificationCenter removeObserver:self];
}

#pragma mark - Notifications

- (void)ap_textFieldDidChange:(NSNotification *)notification
{
    [self validate];
}

- (void)ap_textViewDidChange:(NSNotification *)notification
{
    [self validate];
}

#pragma mark - Override

- (void)validate
{
    [super validate];

    self.valid = [((NSString *) self.validationObject) isEqualToString:((UITextField *) self.secondControl).text];
}

@end