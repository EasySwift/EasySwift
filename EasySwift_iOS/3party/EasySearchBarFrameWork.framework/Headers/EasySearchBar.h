//
//  EasySearchBar.h
//  EasySearchBar
//
//  Created by YXJ on 15/12/22.
//  Copyright © 2015年 YXJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^EasySearchBarTextDidBeginEditingBlock)(UISearchBar *searchBar);
typedef void (^EasySearchBarTextDidChangeBlock)(UISearchBar *searchBar,NSString *searchText);
typedef void (^EasySearchBarTextDidEndEditingBlock)(UISearchBar *searchBar);
typedef void (^EasySearchBarSearchButtonClickedBlock)(UISearchBar *searchBar);
typedef void (^EasyCancelBTClickedBlock)(UISearchBar *searchBar);

@interface EasySearchBar : UIView

@property (nonatomic,copy) NSString *easySearchBarPlaceholder;      /**< 占位符字符串 */
@property (nonatomic,strong) UIColor *easySearchBarPlaceholderColor;/**< 占位符字符串颜色 */
@property (nonatomic,assign) CGFloat easySearchBarHeight;           /**< searchBar高 */
@property (nonatomic,strong) UIColor *easySearchBarTextColor;       /**< 搜索内容字符串颜色 */
@property (nonatomic,strong) UIColor *easyCancelColor;              /**< "取消"文字颜色 */
@property (nonatomic,strong) UIColor *easyBackgroundColor;          /**< 背景颜色 */

/** 开始输入 */
-(void)easySearchBarTextDidBeginEditingBlock:(EasySearchBarTextDidBeginEditingBlock)beginEditingBlock;

/** 输入文字变化 */
-(void)easySearchBarTextDidChangeBlock:(EasySearchBarTextDidChangeBlock)textDidChangeBlock;

/** 结束输入 */
-(void)easySearchBarTextDidEndEditingBlock:(EasySearchBarTextDidEndEditingBlock)endEditingBlock;

/** 点击键盘搜索 */
-(void)easySearchBarSearchButtonClickedBlock:(EasySearchBarSearchButtonClickedBlock)searchButtonClickedBlock;

/** 取消按钮点击 */
-(void)easyCancelBTClickedBlock:(EasyCancelBTClickedBlock)cancelBTClickedBlock;



@end
