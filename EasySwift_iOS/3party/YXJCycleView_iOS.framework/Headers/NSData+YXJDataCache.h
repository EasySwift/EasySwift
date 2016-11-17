//
//  NSData+YXJDataCache.h
//  YXJCycleView
//
//  Created by YXJ on 15-3-30.
//  Copyright (c) 2015年 YXJ. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSData (YXJDataCache)

- (void)saveDataCacheWithIdentifier:(NSString *)identifier;

+ (NSData *)getDataCacheWithIdentifier:(NSString *)identifier;

+ (void)clearCache;

@end
