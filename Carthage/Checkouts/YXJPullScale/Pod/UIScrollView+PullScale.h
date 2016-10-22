//
//  UIScrollView+PullScale.h
//  YXJPullScale
//
//  Created by yuanxiaojun on 16/5/15.
//  Copyright © 2016年 袁晓钧. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXJPullScaleView.h"

@interface UIScrollView (PullScale)

@property (strong, nonatomic) YXJPullScaleView *scaleView;

/**
 *  添加一个下拉放大的功能
 *
 *  @param vc                   所属控制器
 *  @param originalHeight       view的初始高度（关系到contentInset及contentOffset）
 */
-(void)addPullScaleFuncInVC:(UIViewController *)vc originalHeight:(CGFloat)originalHeight hasNavBar:(BOOL)hasNavBar;

@end
