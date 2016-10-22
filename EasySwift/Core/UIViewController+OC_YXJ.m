//
//  UIViewController+OC_YXJ.m
//  NTSLTerminus
//
//  Created by 袁晓钧 on 16/1/21.
//  Copyright © 2016年 袁晓钧. All rights reserved.
//

#import "UIViewController+OC_YXJ.h"

@implementation UIViewController (OC_YXJ)

#pragma mark 设置UITextView的行距
-(void)setTextViewSpace:(UITextView *)textVeiw space:(CGFloat)space{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = space;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:textVeiw.font,
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    textVeiw.attributedText = [[NSAttributedString alloc] initWithString:textVeiw.text attributes:attributes];
}

#pragma mark 是否包含中文字符
-(BOOL)isContainChinese:(NSString *)str{
    BOOL result = NO ;
    for (int i=0; i<str.length; i++) {
        NSString *temp = [str substringWithRange:NSMakeRange(i, 1)];
        
        NSString *match=@"(^[\u4e00-\u9fa5]+$)";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
        result = [predicate evaluateWithObject:temp];
        
        if (result == YES) {
            break ;
        }
    }
    
    return result ;
}

#pragma mark 自动适应页面 standardViewSize:标准view大小
-(void)autoFitView:(NSArray *)constraints standardViewSize:(viewSize)standardViewSize{
    float multiple = 1 ;        //倍数
    
    if (standardViewSize == viewSize_35) {
        multiple = [self ScreenHeight]/480 ;
    }else if (standardViewSize == viewSize_4){
        multiple = [self ScreenHeight]/568 ;
    }else if (standardViewSize == viewSize_47){
        multiple = [self ScreenHeight]/667 ;
    }else if (standardViewSize == viewSize_55){
        multiple = [self ScreenHeight]/736 ;
    }
    
    for (NSLayoutConstraint *cons in constraints) {
        if ([cons isKindOfClass:[NSLayoutConstraint class]]) {
            cons.constant *= multiple;
        }
    }
}
-(void)autoFitView:(NSArray *)constraints multiple:(float)multiple{
    for (NSLayoutConstraint *cons in constraints) {
        if ([cons isKindOfClass:[NSLayoutConstraint class]]) {
            cons.constant *= multiple;
        }
    }
}

- (CGFloat)ScreenHeight{
    return [UIScreen mainScreen].bounds.size.height;
}

@end
