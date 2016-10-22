//
//  YXJSwipeTableViewCell.h
//  YXJSwipeTableViewCell
//
//  Created by YXJ on 9/10/13.
//  Copyright (c) 2013 YXJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>
#import "YXJSwipeCellScrollView.h"
#import "YXJSwipeLongPressGestureRecognizer.h"
#import "YXJSwipeUtilityButtonTapGestureRecognizer.h"
#import "NSMutableArray+YXJSwipeUtilityButtons.h"

@class YXJSwipeTableViewCell;

typedef NS_ENUM(NSInteger, YXJSwipeCellState)
{
    kCellStateCenter,
    kCellStateLeft,
    kCellStateRight,
};

@protocol YXJSwipeTableViewCellDelegate <NSObject>

@optional
- (void)swipeableTableViewCell:(YXJSwipeTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index;
- (void)swipeableTableViewCell:(YXJSwipeTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index;
- (void)swipeableTableViewCell:(YXJSwipeTableViewCell *)cell scrollingToState:(YXJSwipeCellState)state;
- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(YXJSwipeTableViewCell *)cell;
- (BOOL)swipeableTableViewCell:(YXJSwipeTableViewCell *)cell canSwipeToState:(YXJSwipeCellState)state;
- (void)swipeableTableViewCellDidEndScrolling:(YXJSwipeTableViewCell *)cell;
- (void)swipeableTableViewCell:(YXJSwipeTableViewCell *)cell didScroll:(UIScrollView *)scrollView;

@end

@interface YXJSwipeTableViewCell : UITableViewCell

@property (nonatomic, copy) NSArray *leftUtilityButtons;
@property (nonatomic, copy) NSArray *rightUtilityButtons;

@property (nonatomic, weak) id <YXJSwipeTableViewCellDelegate> delegate;

- (void)setRightUtilityButtons:(NSArray *)rightUtilityButtons WithButtonWidth:(CGFloat) width;
- (void)setLeftUtilityButtons:(NSArray *)leftUtilityButtons WithButtonWidth:(CGFloat) width;
- (void)hideUtilityButtonsAnimated:(BOOL)animated;
- (void)showLeftUtilityButtonsAnimated:(BOOL)animated;
- (void)showRightUtilityButtonsAnimated:(BOOL)animated;

- (BOOL)isUtilityButtonsHidden;

@end
