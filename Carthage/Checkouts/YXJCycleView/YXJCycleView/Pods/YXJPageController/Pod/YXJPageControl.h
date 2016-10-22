//
//  YXJPageControl.h
//  YXJPageControl
//
//  Created by YXJ on 2015-01-21.
//  Copyright (c) 2015 YXJ. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class YXJPageControl;
//
//#pragma mark - delegate
//@protocol YXJPageControlDelegate <NSObject>
//
//@optional
//- (void)YXJPageControl:(YXJPageControl *)pageControl didSelectPageAtIndex:(NSInteger)index;
//
//@end


@interface YXJPageControl : UIControl


/**
 * Dot view customization properties
 */

/**
 *  The Class of your custom UIView, make sure to respect the YXJAbstractDotView class.
 */
@property (nonatomic) Class dotViewClass;


/**
 *  UIImage to represent a dot.
 */
@property (nonatomic) UIImage *dotImage;


/**
 *  UIImage to represent current page dot.
 */
@property (nonatomic) UIImage *currentDotImage;


/**
 *  Dot size for dot views. Default is 8 by 8.
 */
@property (nonatomic) CGSize dotSize;


/**
 *  默认是grayColor
 */
@property (nonatomic, strong) UIColor *dotColor;

/**
 *  Spacing between two dot views. Default is 8.
 */
@property (nonatomic) NSInteger spacingBetweenDots;


/**
 * Page control setup properties
 */


/**
 * Delegate for YXJPageControl
 */
//@property (nonatomic,weak) id<YXJPageControlDelegate> delegate;


/**
 *  Number of pages for control. Default is 0.
 */
@property (nonatomic) NSInteger numberOfPages;


/**
 *  Current page on which control is active. Default is 0.
 */
@property (nonatomic) NSInteger currentPage;


/**
 *  Hide the control if there is only one page. Default is NO.
 */
@property (nonatomic) BOOL hidesForSinglePage;


/**
 *  Let the control know if should grow bigger by keeping center, or just get longer (right side expanding). By default YES.
 */
@property (nonatomic) BOOL shouldResizeFromCenter;


/**
 *  Return the minimum size required to display control properly for the given page count.
 *
 *  @param pageCount Number of dots that will require display
 *
 *  @return The CGSize being the minimum size required.
 */
- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount;

@end
