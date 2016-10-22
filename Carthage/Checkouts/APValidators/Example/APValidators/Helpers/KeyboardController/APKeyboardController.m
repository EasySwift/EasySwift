//
// Created by Nickolay Sheika on 18.12.15.
// Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "APKeyboardController.h"

static const CGFloat kKeyboardControllerMarginFromResponder = 20.0f;



@interface APKeyboardController ()


@property(weak, nonatomic) IBOutlet NSLayoutConstraint *containerVerticalAlignmentConstraint;
@property(weak, nonatomic) IBOutlet UIView *mainView;

@end



@implementation APKeyboardController


#pragma mark - Accessors

- (void)setMainView:(UIView *)mainView
{
    _mainView = mainView;

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEventOccurred:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [mainView addGestureRecognizer:tapGestureRecognizer];

    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                                 action:@selector(tapEventOccurred:)];
    swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;
    [mainView addGestureRecognizer:swipeGestureRecognizer];
}

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter addObserver:self
                               selector:@selector(keyboardWillShowNotification:)
                                   name:UIKeyboardWillShowNotification
                                 object:nil];
        [notificationCenter addObserver:self
                               selector:@selector(keyboardWillHideNotification:)
                                   name:UIKeyboardWillHideNotification
                                 object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Gesture Recognizer Action

- (void)tapEventOccurred:(id)sender
{
    [self.mainView endEditing:NO];
}

#pragma mark - Notifications

- (void)keyboardWillShowNotification:(NSNotification *)notification
{
    UIView *firstResponder = [self findFirstResponderInViewHierarchy:self.mainView];
    CGRect firstResponderFrameInMainViewCoords = [self.mainView convertRect:firstResponder.frame fromView:firstResponder.superview];
    CGRect firstResponderFrameWithOffset = CGRectOffset(firstResponderFrameInMainViewCoords, 0, - self.containerVerticalAlignmentConstraint.constant);

    NSDictionary *info = notification.userInfo;
    CGRect keyboardFrame = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    if (firstResponder && CGRectIntersectsRect(firstResponderFrameWithOffset, keyboardFrame)) {
        CGRect intersectionRect = CGRectIntersection(firstResponderFrameWithOffset, keyboardFrame);

        self.containerVerticalAlignmentConstraint.constant = - (intersectionRect.size.height + kKeyboardControllerMarginFromResponder);
        [self animateMainViewWithKeyboardNotification:notification];
    }
}

- (void)keyboardWillHideNotification:(NSNotification *)notification
{
    self.containerVerticalAlignmentConstraint.constant = 0;
    [self animateMainViewWithKeyboardNotification:notification];
}


#pragma mark - Private

- (void)animateMainViewWithKeyboardNotification:(NSNotification *)notification
{
    CGFloat animationDuration = [self keyboardAnimationDuration:notification];
    UIViewAnimationOptions animationCurve = [self keyboardAnimationCurve:notification];

    [UIView animateWithDuration:animationDuration == 0 ? 0.15f : animationDuration
                          delay:0.0f
                        options:animationCurve | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.mainView layoutIfNeeded];
                     }
                     completion:nil];
}

- (CGFloat)keyboardAnimationDuration:(NSNotification *)notification
{
    return [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
}

- (UIViewAnimationOptions)keyboardAnimationCurve:(NSNotification *)notification
{
    return (UIViewAnimationOptions) [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
}

- (UIView *)findFirstResponderInViewHierarchy:(UIView *)view
{
    for (UIView *subview in view.subviews) {
        if ([subview isFirstResponder]) {
            return subview;
        }
        else {
            UIView *result = [self findFirstResponderInViewHierarchy:subview];
            if (result) {
                return result;
            }
        }
    }
    return nil;
}

@end