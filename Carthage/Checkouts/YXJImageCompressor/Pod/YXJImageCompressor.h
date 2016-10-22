//
//  YXJImageCompressor.h
//  CompressImage
//
//  Created by YXJ on 13-11-5.
//  Copyright (c) 2013年 YXJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    _6M     = 1024*1024*6,
    _4M     = 1024*1024*4,
    _2M     = 1024*1024*2,
    _1M     = 1024*1024*1,
    _512K   = 1024*1024/2,
    _256K   = 1024*1024/4,
    _128K   = 1024*1024/8,
    _64K    = 1024*1024/16,
    _32K    = 1024*1024/32,
    _16K    = 1024*1024/64,
    _8K     = 1024*1024/128,
} YXJCompressorLimitSize;

typedef enum : NSUInteger {
    _50PX   = 50,
    _100PX  = 100,
    _150PX  = 150,
    _200PX  = 200,
    _320PX  = 320,
    _375PX  = 375,
    _414PX  = 414,
    _500PX  = 500,
    _600PX  = 600,
    _800PX  = 800,
    _1000PX = 1000,
    _1200PX = 1200,
}YXJCompressorMaxSide;

@interface YXJImageCompressor : NSObject

+ (void)YXJCompressImage:(UIImage *)image limitSize:(YXJCompressorLimitSize)size maxSide:(YXJCompressorMaxSide)length completion:(void (^)(NSData *data))block;

+ (UIImage *)YXJImageWithMaxSide:(YXJCompressorMaxSide)length sourceImage:(UIImage *)image;

@end
