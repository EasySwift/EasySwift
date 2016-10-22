//
//  YXJImageCompressor.m
//  CompressImage
//
//  Created by YXJ on 13-11-5.
//  Copyright (c) 2013年 YXJ. All rights reserved.
//

#import "YXJImageCompressor.h"

@implementation YXJImageCompressor

+ (void)YXJCompressImage:(UIImage *)image limitSize:(YXJCompressorLimitSize)size maxSide:(YXJCompressorMaxSide)length completion:(void (^)(NSData *data))block {
    NSAssert(size > 0, @"图片的大小必须大于 0");
    NSAssert(length > 0, @"图片的最大限制边长必须大于 0");
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 先按比例减少图片的分辨率
        UIImage *img = [YXJImageCompressor YXJImageWithMaxSide:length sourceImage:image];
        
        NSData *imgData = UIImageJPEGRepresentation(img, 0.7);
        if (imgData.length <= size) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(imgData);
            });
            return;
        }
        
        // 如果图片大小仍超过限制大小，则压缩图片的质量
        // 返回以 JPEG 格式表示的图片的二进制数据
        CGFloat quality = 0.7;
        do {
            @autoreleasepool {
                imgData = UIImageJPEGRepresentation(img, quality);
                quality -= 0.05;
            }
        } while (imgData.length > size);
        
        // 返回 压缩后的 imgData
        dispatch_async(dispatch_get_main_queue(), ^{
            // 返回图片的二进制数据
            block(imgData);
        });
    });
}

+ (UIImage *)YXJImageWithMaxSide:(YXJCompressorMaxSide)length sourceImage:(UIImage *)image{
    if (image.size.width <= length && image.size.height <= length) {
        return image;
    }
    
//    CGFloat scale = [[UIScreen mainScreen] scale];
    CGSize imgSize = CWSizeReduce(image.size, length);
    UIImage *img = nil;
    
    //1代表1X
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    
    [image drawInRect:CGRectMake(0, 0, imgSize.width, imgSize.height)
            blendMode:kCGBlendModeNormal alpha:1.0];
    
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

#pragma mark - Utility
static inline
CGSize CWSizeReduce(CGSize size, CGFloat limit) {// 按比例减少尺寸
    CGFloat max = MAX(size.width, size.height);
    if (max < limit) {
        return size;
    }
    
    CGSize imgSize;
    CGFloat ratio = size.height / size.width;
    
    if (size.width > size.height) {
        imgSize = CGSizeMake(limit, limit*ratio);
    } else {
        imgSize = CGSizeMake(limit/ratio, limit);
    }
    
    return imgSize;
}

@end
