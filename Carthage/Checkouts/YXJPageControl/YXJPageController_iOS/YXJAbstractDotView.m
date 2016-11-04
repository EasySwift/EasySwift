//
//  YXJAbstractDotView.m
//  YXJPageControl
//
//  Created by YXJ on 2015-01-22.
//  Copyright (c) 2015 YXJ. All rights reserved.
//

#import "YXJAbstractDotView.h"


@implementation YXJAbstractDotView


- (id)init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in %@", NSStringFromSelector(_cmd), self.class]
                                 userInfo:nil];
}


- (void)changeActivityState:(BOOL)active
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in %@", NSStringFromSelector(_cmd), self.class]
                                 userInfo:nil];
}

@end
