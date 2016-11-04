//
//  LeftMenuViewController.h
//  test123
//
//  Created by kf1 on 14-9-16.
//  Copyright (c) 2014年 kf1. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LeftMenuPanDirection) {
    LeftMenuPanDirectionLeft = 0,   /**< 左方向*/
    LeftMenuPanDirectionRight,      /**< 右方向*/
};

typedef NS_ENUM(NSUInteger, AnimationType) {
    AnimationTransition = 0,                /**< 只有位移动画*/
    AnimationTransitionAndScale,            /**< 位移加缩放动画*/
    AnimationTransitionAndScaleAndIncline,  /**< 位移加缩放加倾斜动画*/
};

@interface FLSideSlipViewController : UIViewController<UIGestureRecognizerDelegate>
{
    CGFloat g_currentTranslateX;            /**< 当前x轴距离*/
    LeftMenuPanDirection g_panDirection;    /**< 滑动方向*/
    UIView *g_overView;
    
    struct {
        unsigned int showingLeftView:1;
        unsigned int showingRightView:1;
        unsigned int canShowRight:1;
        unsigned int canShowLeft:1;
    } g_menuFlags;
    
    UITapGestureRecognizer *g_tap;
}

@property (nonatomic, retain) UIViewController *rootViewController;
@property (nonatomic, retain) UIViewController *leftViewController;
@property (nonatomic, retain) UIViewController *rightViewController;
@property (nonatomic, assign) CGFloat          leftDistance;           /**< 左滑距离*/
@property (nonatomic, assign) CGFloat          scaleSize;              /**< 缩放大小 0-1,动画类型为AnimationTransition时该属性无效*/
@property (nonatomic, assign) BOOL             canSlideInPush;          /**< push后的controller中能否滑出菜单*/
@property (nonatomic, assign) AnimationType    animationType;           /**< 动画类型*/

- (id)initWithRootViewController:(UIViewController *)viewController;
- (void)setNewRootViewController:(UIViewController *)viewController animation:(BOOL)animation;
/**
 *  侧边栏菜单点击后在主界面跳转界面
 *
 *  @param viewController 要跳转的界面
 *  @param animation      是否打开动画
 */
- (void)pushToNewViewController:(UIViewController *)viewController animation:(BOOL)animation;
/**
 *  左上角按钮点击事件
 */
- (void)showLeftViewController;

/**
 *  主界面点击事件，返回到主界面
 */
-(void)showRootViewController:(BOOL)animation;

@end
