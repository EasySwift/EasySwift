//
//  UIViewController+OC_YXJ.h
//  NTSLTerminus
//
//  Created by 袁晓钧 on 16/1/21.
//  Copyright © 2016年 袁晓钧. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum:NSInteger{
    viewSize_35,
    viewSize_4,
    viewSize_47,
    viewSize_55
}viewSize;

@interface UIViewController (OC_YXJ)

#pragma mark 设置UITextView的行距
-(void)setTextViewSpace:(UITextView *)textVeiw space:(CGFloat)space;

#pragma mark 是否包含中文字符
-(BOOL)isContainChinese:(NSString *)str;

#pragma mark 自动适应页面 standardViewSize:标准view大小
-(void)autoFitView:(NSArray *)constraints standardViewSize:(viewSize)standardViewSize;
-(void)autoFitView:(NSArray *)constraints multiple:(float)multiple;

@end
