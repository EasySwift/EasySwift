//
//  EasyCountDownButton.h
//  EasyCountDownButton
//
//  Created by YXJ on 15/3/8.
//  Copyright (c) 2015年 YXJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EasyCountDownButtonConfig : NSObject

@property(nonatomic,strong)UIFont           *font;
@property(nonatomic,copy)  NSString         *title;
@property(nonatomic,strong)UIColor          *titleColor;
@property(nonatomic,strong)UIColor          *backgroundColor;
@property(nonatomic,strong)UIImage          *backgroundImage;

- (instancetype)initWithFont:(UIFont*)font title:(NSString *)title titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor backgroundImage:(UIImage *)backgroundImage;

@end

@class EasyCountDownButton;

typedef NSString* (^DidChangeBlock)  (EasyCountDownButton *countDownButton,int second);
typedef void      (^DidFinishedBlock)(EasyCountDownButton *countDownButton,int second);
typedef void      (^TouchedDownBlock)(EasyCountDownButton *countDownButton,NSInteger tag);

@interface EasyCountDownButton : UIButton

@property(nonatomic,strong)EasyCountDownButtonConfig  *disableConfig;
@property(nonatomic,strong)EasyCountDownButtonConfig  *enableConfig;

//- (void)setBtnSelect:(BOOL)state;
- (void)startWithSecond:(int)second;
- (void)addToucheHandler:(TouchedDownBlock)touchHandler;
- (void)didChange:(DidChangeBlock)didChangeBlock;
- (void)didFinished:(DidFinishedBlock)didFinishedBlock;
- (void)stop;

@end
