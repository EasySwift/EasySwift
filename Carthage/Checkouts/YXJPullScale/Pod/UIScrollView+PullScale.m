//
//  UIScrollView+PullScale.m
//  YXJPullScale
//
//  Created by yuanxiaojun on 16/5/15.
//  Copyright © 2016年 袁晓钧. All rights reserved.
//

#import "UIScrollView+PullScale.h"
#import "YXJPullScaleView.h"
#import <objc/runtime.h>

#pragma mark - 运行时相关
static char YXJPullScaleViewKey;

@implementation UIScrollView (PullScale)


/**
 *  添加一个下拉放大的功能
 *
 *  @param vc                   所属控制器
 *  @param originalHeight       View的初始高度（关系到contentInset及contentOffset）
 */
-(void)addPullScaleFuncInVC:(UIViewController *)vc originalHeight:(CGFloat)originalHeight hasNavBar:(BOOL)hasNavBar{
    
    YXJPullScaleView *tempView=[[YXJPullScaleView alloc] init];
    
    //记录
    self.scaleView = tempView;
    
    //数据传递
    tempView.hasNavBar = hasNavBar;
    tempView.originalHeight = originalHeight;
    tempView.vc = vc;

    CGFloat height=originalHeight;
    
    /**
     *  contentInset
     */
    //取出之前的contentInset
    UIEdgeInsets contentInset=self.contentInset;
    
    //设置contentInset
    contentInset.top+=height;
    self.contentInset=contentInset;
    
    
    /**
     *  contentOffset
     */
    //取出之前的contentOffset
    CGPoint contentOffsett=self.contentOffset;
    
    //设置contentOffset
    contentOffsett.y-=height;
    self.contentOffset=contentOffsett;
    
    //添加控件
    [self addSubview:tempView];
}


#pragma mark 使用运行时模拟成员变量
-(void)setScaleView:(YXJPullScaleView *)scaleView{
    [self willChangeValueForKey:@"YXJPullScaleViewKey"];
    objc_setAssociatedObject(self, &YXJPullScaleViewKey,
                             scaleView,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"YXJPullScaleViewKey"];
}

-(YXJPullScaleView *)scaleView{
    return objc_getAssociatedObject(self, &YXJPullScaleViewKey);
}




@end
