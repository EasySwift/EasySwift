//
//  YXJSwipeUtilityButtonView.h
//  YXJSwipeTableViewCell
//
//  Created by YXJ on 11/27/13.
//  Copyright (c) 2013 YXJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXJSwipeTableViewCell;

#define kUtilityButtonWidthDefault 90

@interface YXJSwipeUtilityButtonView : UIView

- (id)initWithUtilityButtons:(NSArray *)utilityButtons parentCell:(YXJSwipeTableViewCell *)parentCell utilityButtonSelector:(SEL)utilityButtonSelector;
- (id)initWithFrame:(CGRect)frame utilityButtons:(NSArray *)utilityButtons parentCell:(YXJSwipeTableViewCell *)parentCell utilityButtonSelector:(SEL)utilityButtonSelector;

@property (nonatomic, weak, readonly) YXJSwipeTableViewCell *parentCell;
@property (nonatomic, copy) NSArray *utilityButtons;
@property (nonatomic, assign) SEL utilityButtonSelector;

- (void)setUtilityButtons:(NSArray *)utilityButtons WithButtonWidth:(CGFloat)width;
- (void)pushBackgroundColors;
- (void)popBackgroundColors;

@end
