//
//  YXJSlideContentView.h
//  YXJSlideBarDemo
//
//  Created by YXJ on 15/7/1.
//  Copyright (c) 2015年 YXJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YXJSlideContentViewScrollCallback)(NSUInteger index);

@protocol YXJSlideContentViewDataSource;
//@protocol YXJSlideContentViewDelegate;

@interface YXJSlideContentView : UIView

@property (weak, nonatomic) id<YXJSlideContentViewDataSource> dataSource;
//@property (weak, nonatomic) id<YXJSlideContentViewDelegate> delegate;

// Add the calback when the slide content view be scrolled completely
- (void)slideContentViewScrollFinished:(YXJSlideContentViewScrollCallback)callback;

// Set the slide content view to show content at index
- (void)scrollSlideContentViewToIndex:(NSUInteger)index;

//设置是否可滑动
- (void)setIsEnableScroll:(BOOL)isEnable;

@end

@protocol YXJSlideContentViewDataSource <NSObject>

// Get the view controller for the index of the content view
- (UIViewController *)slideContentView:(YXJSlideContentView *)contentView viewControllerForIndex:(NSUInteger)index;

// Get the num of content view
- (NSInteger)numOfContentView;

@end
