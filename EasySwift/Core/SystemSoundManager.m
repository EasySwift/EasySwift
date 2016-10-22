//
//  SystemSoundManager.m
//  NTSLTerminus
//
//  Created by YXJ on 16/2/1.
//  Copyright © 2016年 YXJ. All rights reserved.
//

#import "SystemSoundManager.h"

#import <AudioToolbox/AudioToolbox.h>


@interface SystemSoundManager ()

@property (nonatomic,assign)SystemSoundID  mesFreshSound;

@end

@implementation SystemSoundManager

- (id)init {
    self = [super init];
    if (self) {
        NSURL * urlMessage  = [[NSBundle mainBundle] URLForResource:@"office" withExtension:@"mp3"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)(urlMessage),&_mesFreshSound);
    }
    return self;
}

- (void)playMsgReceived{
    if (&_mesFreshSound != nil) {
        AudioServicesPlaySystemSound(_mesFreshSound);
    }

    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
}
@end
