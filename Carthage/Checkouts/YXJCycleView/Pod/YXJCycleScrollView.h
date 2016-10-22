//
//  YXJCycleScrollView.h
//  YXJCycleScrollView
//
//  Created by YXJ on 15-3-22.
//  Copyright (c) 2015年 YXJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YXJPageControl.h"

typedef enum {
    YXJCycleScrollViewPageContolAlimentCenter,
    YXJCycleScrollViewPageContolAlimentRight
} YXJCycleScrollViewPageContolAliment;

typedef enum {
    YXJCycleScrollViewPageContolStyleAnimated,       // 动画效果pagecontrol
    YXJCycleScrollViewPageContolStyleClassic,        // 系统自带经典样式
    YXJCycleScrollViewPageContolStyleNone            // 不显示pagecontrol
} YXJCycleScrollViewPageContolStyle;

@class YXJCycleScrollView;

@protocol YXJCycleScrollViewDelegate <NSObject>

@optional
- (void)cycleScrollView:(YXJCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;

- (void)cycleScrollView:(YXJCycleScrollView *)cycleScrollView didSwipeItemAtIndex:(NSInteger)index;

@end

@interface YXJCycleScrollView : UIView



// >>>>>>>>>>>>>>>>>>>>>>>>>>  数据源接口
// 本地图片数组
@property (nonatomic, strong) NSArray *localizationImagesGroup;

// 网络图片 url string 数组
@property (nonatomic, strong) NSArray *imageURLStringsGroup;

// 任意的view
@property (nonatomic, strong) NSArray *views;

// 每张图片对应要显示的文字数组
@property (nonatomic, strong) NSArray *titlesGroup;





// >>>>>>>>>>>>>>>>>>>>>>>>>  滚动控制接口
// 自动滚动间隔时间,默认5s
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;

// 是否无限循环,默认Yes
@property(nonatomic,assign) BOOL infiniteLoop;

// 是否自动滚动,默认Yes
@property(nonatomic,assign) BOOL autoScroll;

@property (nonatomic, weak) id<YXJCycleScrollViewDelegate> delegate;




// >>>>>>>>>>>>>>>>>>>>>>>>>  自定义样式接口
// 占位图，用于网络未加载到图片时
@property (nonatomic, strong) UIImage *placeholderImage;

//pageControl
@property (nonatomic, strong) YXJPageControl *pageControl;

// 是否显示分页控件
@property (nonatomic, assign) BOOL showPageControl;

// 分页控件位置
@property (nonatomic, assign) YXJCycleScrollViewPageContolAliment pageControlAliment;

// pagecontrol 样式，默认为动画样式
@property (nonatomic, assign) YXJCycleScrollViewPageContolStyle pageControlStyle;

@property (nonatomic, strong) UIColor *titleLabelTextColor;
@property (nonatomic, strong) UIFont  *titleLabelTextFont;
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;
@property (nonatomic, assign) CGFloat titleLabelHeight;



// >>>>>>>>>>>>>>>>>>>>>>>>>  清除缓存接口
- (void)clearCache;

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame viewsGroup:(NSArray *)viewsGroup;
+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imagesGroup:(NSArray *)imagesGroup;
+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imageURLStringsGroup:(NSArray *)imageURLStringsGroup;

@end
