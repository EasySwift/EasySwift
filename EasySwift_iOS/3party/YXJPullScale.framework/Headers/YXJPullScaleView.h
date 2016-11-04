//
//  YXJPullScaleView.h
//  YXJPullScale
//
//  Created by yuanxiaojun on 16/5/15.
//  Copyright © 2016年 袁晓钧. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXJPullScaleView : UIView

/**
 *  内容view
 */
@property (nonatomic,weak) UIView *mainView;

/**
 *  将被放大的图片
 */
@property (nonatomic,weak) UIView *scaleImage;

/**
 *  View的初始高度（关系到contentInset及contentOffset）
 */
@property (nonatomic,assign) CGFloat originalHeight;///是什么

/**
 *  是否含有导航条
 */
@property (nonatomic,assign) BOOL hasNavBar;


/**
 *  所属控制器
 */
@property (nonatomic,weak) UIViewController *vc;


@end
