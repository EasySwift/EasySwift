//
//  YXJSlideBar.h
//  YXJSlideBarDemo
//
//  Created by YXJ on 15/6/4.
//  Copyright (c) 2015年 YXJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YXJSlideBarItemSelectedCallback)(NSUInteger idx);

@interface YXJSlideBar : UIView

//自定义每个item的宽度
- (instancetype)initWithItemWidth:(CGFloat)itemWidth barHeight:(CGFloat)barHeight;

// 选中之后的回调
- (void)slideBarItemSelectedCallback:(YXJSlideBarItemSelectedCallback)callback;

// 手动选中第几个
- (void)selectSlideBarItemAtIndex:(NSUInteger)index;

// 标题
@property (copy, nonatomic)     NSArray     *itemsTitle;

// 未选中的字体颜色
@property (strong, nonatomic)   UIColor     *itemColor;

// 选中的字体颜色
@property (strong, nonatomic)   UIColor     *itemSelectedColor;

// 线条颜色
@property (strong, nonatomic)   UIColor     *sliderColor;

@end
