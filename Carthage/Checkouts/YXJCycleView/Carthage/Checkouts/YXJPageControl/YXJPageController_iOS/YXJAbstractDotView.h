//
//  YXJAbstractDotView.h
//  YXJPageControl
//
//  Created by YXJ on 2015-01-22.
//  Copyright (c) 2015 YXJ. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YXJAbstractDotView : UIView


/**
 *  A method call let view know which state appearance it should take. Active meaning it's current page. Inactive not the current page.
 *
 *  @param active BOOL to tell if view is active or not
 */
- (void)changeActivityState:(BOOL)active;


@end

