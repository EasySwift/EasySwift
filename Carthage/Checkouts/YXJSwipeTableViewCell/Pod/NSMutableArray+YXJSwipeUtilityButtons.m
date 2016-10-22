//
//  NSMutableArray+YXJSwipeUtilityButtons.m
//  YXJSwipeTableViewCell
//
//  Created by YXJ on 11/27/13.
//  Copyright (c) 2013 YXJ. All rights reserved.
//

#import "NSMutableArray+YXJSwipeUtilityButtons.h"

@implementation NSMutableArray (YXJSwipeUtilityButtons)

- (void)YXJ_addUtilityButtonWithColor:(UIColor *)color title:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = color;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [self addObject:button];
}

- (void)YXJ_addUtilityButtonWithColor:(UIColor *)color attributedTitle:(NSAttributedString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = color;
    [button setAttributedTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addObject:button];
}

- (void)YXJ_addUtilityButtonWithColor:(UIColor *)color icon:(UIImage *)icon
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = color;
    [button setImage:icon forState:UIControlStateNormal];
    [self addObject:button];
}

- (void)YXJ_addUtilityButtonWithColor:(UIColor *)color normalIcon:(UIImage *)normalIcon selectedIcon:(UIImage *)selectedIcon {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = color;
    [button setImage:normalIcon forState:UIControlStateNormal];
    [button setImage:selectedIcon forState:UIControlStateHighlighted];
    [button setImage:selectedIcon forState:UIControlStateSelected];
    [self addObject:button];
}

- (void)YXJ_addUtilityButtonWithColor:(UIColor *)bgColor title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font normalIcon:(UIImage *)normalIcon selectedIcon:(UIImage *)selectedIcon position:(SSImagePositionType)position space:(CGFloat)space{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = bgColor;
    [button setImage:normalIcon forState:UIControlStateNormal];
    [button setImage:selectedIcon forState:UIControlStateHighlighted];
    [button setImage:selectedIcon forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button.titleLabel setFont:font];
    [button setImagePositionWithType:position spacing:space];
    [self addObject:button];
}

@end


@implementation NSArray (YXJSwipeUtilityButtons)

- (BOOL)YXJ_isEqualToButtons:(NSArray *)buttons
{
    buttons = [buttons copy];
    if (!buttons || self.count != buttons.count) return NO;
    
    for (NSUInteger idx = 0; idx < self.count; idx++) {
        id buttonA = self[idx];
        id buttonB = buttons[idx];
        if (![buttonA isKindOfClass:[UIButton class]] || ![buttonB isKindOfClass:[UIButton class]]) return NO;
        if (![[self class] YXJ_button:buttonA isEqualToButton:buttonB]) return NO;
    }
    
    return YES;
}

+ (BOOL)YXJ_button:(UIButton *)buttonA isEqualToButton:(UIButton *)buttonB
{
    if (!buttonA || !buttonB) return NO;
    
    UIColor *backgroundColorA = buttonA.backgroundColor;
    UIColor *backgroundColorB = buttonB.backgroundColor;
    BOOL haveEqualBackgroundColors = (!backgroundColorA && !backgroundColorB) || [backgroundColorA isEqual:backgroundColorB];
    
    NSString *titleA = [buttonA titleForState:UIControlStateNormal];
    NSString *titleB = [buttonB titleForState:UIControlStateNormal];
    BOOL haveEqualTitles = (!titleA && !titleB) || [titleA isEqualToString:titleB];
    
    UIImage *normalIconA = [buttonA imageForState:UIControlStateNormal];
    UIImage *normalIconB = [buttonB imageForState:UIControlStateNormal];
    BOOL haveEqualNormalIcons = (!normalIconA && !normalIconB) || [normalIconA isEqual:normalIconB];
    
    UIImage *selectedIconA = [buttonA imageForState:UIControlStateSelected];
    UIImage *selectedIconB = [buttonB imageForState:UIControlStateSelected];
    BOOL haveEqualSelectedIcons = (!selectedIconA && !selectedIconB) || [selectedIconA isEqual:selectedIconB];
    
    return haveEqualBackgroundColors && haveEqualTitles && haveEqualNormalIcons && haveEqualSelectedIcons;
}

@end
