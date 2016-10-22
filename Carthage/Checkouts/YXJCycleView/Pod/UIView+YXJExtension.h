//
//  UIView+YXJExtension.h
//  YXJRefreshView
//
//  Created by YXJ on 15-2-23.
//  Copyright (c) 2015年 YXJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define YXJColorCreater(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]


@interface UIView (YXJExtension)

@property (nonatomic, assign) CGFloat sd_height;
@property (nonatomic, assign) CGFloat sd_width;

@property (nonatomic, assign) CGFloat sd_y;
@property (nonatomic, assign) CGFloat sd_x;

@end
