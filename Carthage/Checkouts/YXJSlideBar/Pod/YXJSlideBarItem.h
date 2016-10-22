//
//  YXJSlideBarItem.h
//  YXJSlideBarDemo
//
//  Created by YXJ on 15/6/4.
//  Copyright (c) 2015年 YXJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YXJSlideBarItemDelegate;

@interface YXJSlideBarItem : UIView

@property (assign, nonatomic) BOOL selected;
@property (weak, nonatomic) id<YXJSlideBarItemDelegate> delegate;

- (void)setItemTitle:(NSString *)title;
- (void)setItemTitleFont:(CGFloat)fontSize;
- (void)setItemTitleColor:(UIColor *)color;
- (void)setItemSelectedTileFont:(CGFloat)fontSize;
- (void)setItemSelectedTitleColor:(UIColor *)color;

+ (CGFloat)widthForTitle:(NSString *)title;

@end

@protocol YXJSlideBarItemDelegate <NSObject>

- (void)slideBarItemSelected:(YXJSlideBarItem *)item;

@end
