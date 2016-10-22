//
//  EasyCountDownButton.m
//  EasyCountDownButton
//
//  Created by YXJ on 15/3/8.
//  Copyright (c) 2015年 YXJ. All rights reserved.
//

#import "EasyCountDownButton.h"

@implementation EasyCountDownButtonConfig : NSObject

- (instancetype)initWithFont:(UIFont*)font title:(NSString *)title titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor backgroundImage:(UIImage *)backgroundImage{
    self = [super init];
    if (self) {
        _font = font;
        _title = title;
        _titleColor = titleColor;
        _backgroundColor = backgroundColor;
        _backgroundImage = backgroundImage;
    }
    return self;
}

@end


@implementation EasyCountDownButton{
    int _second;
    int _totalSecond;
    
    NSTimer *_timer;
    NSDate *_startDate;
    
    DidChangeBlock _didChangeBlock;
    DidFinishedBlock _didFinishedBlock;
    TouchedDownBlock _touchedDownBlock;
}

#pragma -mark touche action
-(void)addToucheHandler:(TouchedDownBlock)touchHandler{
    [self setBtnEnabled:YES];
    _touchedDownBlock = [touchHandler copy];
    [self addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)touched:(EasyCountDownButton*)sender{
    if (_touchedDownBlock) {
        self.enabled = NO;
        [self setBtnEnabled:NO];
        
        _touchedDownBlock(sender,sender.tag);
    }
}

#pragma -mark count down method
-(void)startWithSecond:(int)totalSecond{
    _totalSecond = totalSecond;
    _second = totalSecond;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
    _startDate = [NSDate date];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}
-(void)timerStart:(NSTimer *)theTimer {
     double deltaTime = [[NSDate date] timeIntervalSinceDate:_startDate];
    
     _second = _totalSecond - (int)(deltaTime+0.5) ;

    if (_second < 0.0){
        [self stop];
    }else{
        if (_didChangeBlock){
            [self setTitle:_didChangeBlock(self,_second) forState:UIControlStateNormal];
            [self setTitle:_didChangeBlock(self,_second) forState:UIControlStateDisabled];
        }else{
            NSString *title = [NSString stringWithFormat:@"%d秒",_second];
            [self setTitle:title forState:UIControlStateNormal];
            [self setTitle:title forState:UIControlStateDisabled];
        }
    }
}

- (void)stop{
    if (_timer) {
        if ([_timer respondsToSelector:@selector(isValid)]){
            if ([_timer isValid]){
                [_timer invalidate];
                _second = _totalSecond;
                if (_didFinishedBlock){
                    self.enabled = YES;
                    [self setBtnEnabled:YES];
                }else{
                    [self setTitle:@"重新获取" forState:UIControlStateNormal];
                    [self setTitle:@"重新获取" forState:UIControlStateDisabled];
                }
            }
        }
    }
}

#pragma -mark block
-(void)didChange:(DidChangeBlock)didChangeBlock{
    _didChangeBlock = [didChangeBlock copy];
}

-(void)didFinished:(DidFinishedBlock)didFinishedBlock{
    _didFinishedBlock = [didFinishedBlock copy];
}

#pragma mark 配置
/**
 *  选中状态对应disable，不选中状态对应enable
 *
 *  @param enabled 状态
 */
-(void)setBtnEnabled:(BOOL)enabled{
    if (enabled == YES) {
        self.titleLabel.font = _enableConfig.font;
        [self setTitle:_enableConfig.title forState:UIControlStateNormal];
        [self setTitleColor:_enableConfig.titleColor forState:UIControlStateNormal];
        self.backgroundColor = _enableConfig.backgroundColor;
        [self setImage:_enableConfig.backgroundImage forState:UIControlStateNormal];
    }else{
        self.titleLabel.font = _disableConfig.font;
        [self setTitle:_disableConfig.title forState:UIControlStateDisabled];
        [self setTitleColor:_disableConfig.titleColor forState:UIControlStateDisabled];
        self.backgroundColor = _disableConfig.backgroundColor;
        [self setImage:_disableConfig.backgroundImage forState:UIControlStateDisabled];
    }
}

@end
