//
//  YXJKxMenu.h
//  YXJKxMenu
//
//  Created by YXJ on 9/25/15.
//  Copyright © 2015 YXJ. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YXJKxMenuItem : NSObject

@property (readwrite, nonatomic, strong) UIImage *image;
@property (readwrite, nonatomic, strong) NSString *title;
@property (readwrite, nonatomic, weak) id target;
@property (readwrite, nonatomic) SEL action;
@property (readwrite, nonatomic, strong) UIColor *foreColor;
@property (readwrite, nonatomic) NSTextAlignment alignment;

+ (instancetype) menuItem:(NSString *) title
                    image:(UIImage *) image
                   target:(id)target
                   action:(SEL) action;

@end

typedef struct{
    CGFloat R;
    CGFloat G;
    CGFloat B;
    
}Color;

typedef struct {
    CGFloat arrowSize;              //指示箭头大小
    CGFloat marginXSpacing;         //MenuItem左右边距
    CGFloat marginYSpacing;         //MenuItem上下边距
    CGFloat intervalSpacing;        //MenuItemImage与MenuItemTitle的间距
    CGFloat menuCornerRadius;       //菜单圆角半径
    Boolean maskToBackground;       //是否添加覆盖在原View上的半透明遮罩
    Boolean shadowOfMenu;           //是否添加菜单阴影
    Boolean hasSeperatorLine;       //是否设置分割线
    Boolean seperatorLineHasInsets; //是否在分割线两侧留下Insets
    Color textColor;                //menuItem字体颜色
    Color menuBackgroundColor;      //菜单的底色
    CGFloat setWidth;               //为0的话宽度自适应，大于0则为指定的宽度
}OptionalConfiguration;


@interface YXJKxMenuView : UIView

@property (atomic, assign) OptionalConfiguration YXJkxMenuViewOptions;

@end

@interface YXJKxMenu : NSObject

+ (void) showMenuInView:(UIView *)view
               fromRect:(CGRect)rect
              menuItems:(NSArray *)menuItems
            withOptions:(OptionalConfiguration) options;

+ (void) dismissMenu;

+ (UIColor *) tintColor;
+ (void) setTintColor: (UIColor *) tintColor;

+ (UIFont *) titleFont;
+ (void) setTitleFont: (UIFont *) titleFont;

@end
