//
//  NSMutableArray+YXJSwipeUtilityButtons.h
//  YXJSwipeTableViewCell
//
//  Created by YXJ on 11/27/13.
//  Copyright (c) 2013 YXJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+YXJEdgeInsets.h"

@interface NSMutableArray (YXJSwipeUtilityButtons)

- (void)YXJ_addUtilityButtonWithColor:(UIColor *)color title:(NSString *)title;
- (void)YXJ_addUtilityButtonWithColor:(UIColor *)color attributedTitle:(NSAttributedString *)title;
- (void)YXJ_addUtilityButtonWithColor:(UIColor *)color icon:(UIImage *)icon;
- (void)YXJ_addUtilityButtonWithColor:(UIColor *)color normalIcon:(UIImage *)normalIcon selectedIcon:(UIImage *)selectedIcon;
- (void)YXJ_addUtilityButtonWithColor:(UIColor *)bgColor title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font normalIcon:(UIImage *)normalIcon selectedIcon:(UIImage *)selectedIcon position:(YXJImagePositionType)position space:(CGFloat)space;

@end


@interface NSArray (YXJSwipeUtilityButtons)

- (BOOL)YXJ_isEqualToButtons:(NSArray *)buttons;

@end
