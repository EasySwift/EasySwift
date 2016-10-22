//
//  EasySearchBar.m
//  MySetsDemo
//
//  Created by YXJ on 15/12/22.
//  Copyright © 2015年 YXJ. All rights reserved.
//

#import "EasySearchBar.h"
#import <objc/runtime.h>

#define colorRGBValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000)>>16))/255.0 green:((float)((rgbValue & 0xFF00)>>8))/255.0  blue:((float)((rgbValue & 0xFF)))/255.0  alpha:1.0]

#define fontColor colorRGBValue(0x333333)

#define fontLightColor colorRGBValue(0xababab)

#define SCREENWIDTH [[UIScreen mainScreen]bounds].size.width      //屏宽
#define SCREENHEIGHT [[UIScreen mainScreen]bounds].size.height   //  屏高

//searchbar
#define searchBarHeight 24
#define fontName @"STHeitiSC-Light"

static const char EasySearchBarTextDidBeginEditingBlockKey;
static const char EasySearchBarTextDidChangeBlockKey;
static const char EasySearchBarTextDidEndEditingBlockKey;
static const char EasySearchBarSearchButtonClickedBlockKey;
static const char EasyCancelBTClickedBlockKey;

@interface EasySearchBar ()<UISearchBarDelegate>{
    UISearchBar *_searchBar;
    UITextField *_searchField;
    UIButton *_cancelBT;
}
@end

@implementation EasySearchBar

-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaultProperty];
        [self setupSearchBar];
        [self creatCancelButton];
    }
    return self;
}
/*!
 *  设置属性默认值
 */
-(void)setDefaultProperty{
    _easySearchBarPlaceholder = @"search";
    _easySearchBarPlaceholderColor = fontLightColor;
    _easySearchBarHeight = searchBarHeight;
    _easySearchBarTextColor = fontColor;
    _easyCancelColor = fontColor;
}
/*!
 *  添加一个searchBar到View上
 */
-(void)setupSearchBar{
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.delegate = self;
    _searchBar.frame = CGRectMake(10, (self.frame.size.height-_easySearchBarHeight)/2, self.frame.size.width-20, _easySearchBarHeight);
    _searchBar.backgroundColor = [UIColor whiteColor];
    _searchBar.barTintColor = [UIColor whiteColor];
    //_searchBar.alpha = 0.83;
    _searchBar.tintColor = fontLightColor;// 左边竖直闪动光标颜色
    _searchBar.layer.cornerRadius = _easySearchBarHeight/2;//高度一半（高为24）
    _searchBar.layer.masksToBounds = YES;
    _searchBar.placeholder = _easySearchBarPlaceholder;
    
    UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
    _searchField = searchField;
    // Change search bar text color
    searchField.textColor = _easySearchBarTextColor;
    searchField.font = [UIFont fontWithName:fontName size:14];
    // Change the search bar placeholder text color
    [searchField setValue:_easySearchBarPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self addSubview:_searchBar];
}
/*!
 *  添加一个取消按钮到View上
 */
-(void)creatCancelButton{
    float orginX = self.frame.size.width - 50;
    UIButton * cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(orginX, 5, 40, self.frame.size.height-10)];
    _cancelBT = cancelBtn;
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:_easyCancelColor forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont fontWithName:fontName size:14];
    [cancelBtn addTarget:self action:@selector(cancelSearchTouchAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    cancelBtn.hidden = YES;
}
-(void)cancelSearchTouchAction{
    EasyCancelBTClickedBlock cancelBTClickedBlock = (EasyCancelBTClickedBlock)objc_getAssociatedObject(_searchBar, &EasyCancelBTClickedBlockKey);
    if (cancelBTClickedBlock) {
        cancelBTClickedBlock(_searchBar);
        _searchBar.frame = CGRectMake(10, (self.frame.size.height-_easySearchBarHeight)/2, self.frame.size.width-20, _easySearchBarHeight);
        _cancelBT.hidden = YES;
        [_searchBar resignFirstResponder];
    }
}
/** 取消按钮点击 */
-(void)easyCancelBTClickedBlock:(EasyCancelBTClickedBlock)cancelBTClickedBlock{
    objc_setAssociatedObject(_searchBar, &EasyCancelBTClickedBlockKey, cancelBTClickedBlock, OBJC_ASSOCIATION_COPY);
}

#pragma mark --- 代理转为方法调用
/** 开始输入 */
-(void)easySearchBarTextDidBeginEditingBlock:(EasySearchBarTextDidBeginEditingBlock)beginEditingBlock{
    objc_setAssociatedObject(_searchBar, &EasySearchBarTextDidBeginEditingBlockKey, beginEditingBlock, OBJC_ASSOCIATION_COPY);
}

/** 输入文字变化 */
-(void)easySearchBarTextDidChangeBlock:(EasySearchBarTextDidChangeBlock)textDidChangeBlock{
    objc_setAssociatedObject(_searchBar, &EasySearchBarTextDidChangeBlockKey, textDidChangeBlock, OBJC_ASSOCIATION_COPY);
}

/** 结束输入 */
-(void)easySearchBarTextDidEndEditingBlock:(EasySearchBarTextDidEndEditingBlock)endEditingBlock{
    objc_setAssociatedObject(_searchBar, &EasySearchBarTextDidEndEditingBlockKey, endEditingBlock, OBJC_ASSOCIATION_COPY);
}

/** 点击键盘搜索 */
-(void)easySearchBarSearchButtonClickedBlock:(EasySearchBarSearchButtonClickedBlock)searchButtonClickedBlock{
    objc_setAssociatedObject(_searchBar, &EasySearchBarSearchButtonClickedBlockKey, searchButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

#pragma mark --- UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}
#pragma mark --- 键盘开始输入
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    EasySearchBarTextDidBeginEditingBlock beginEditingBlock = (EasySearchBarTextDidBeginEditingBlock)objc_getAssociatedObject(searchBar, &EasySearchBarTextDidBeginEditingBlockKey);
    if (beginEditingBlock) {
        beginEditingBlock(searchBar);
        _searchBar.frame = CGRectMake(10, (self.frame.size.height-_easySearchBarHeight)/2, self.frame.size.width-60, _easySearchBarHeight);
        _cancelBT.hidden = NO;
    }
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    EasySearchBarTextDidChangeBlock textDidChangeBlock = (EasySearchBarTextDidChangeBlock)objc_getAssociatedObject(searchBar, &EasySearchBarTextDidChangeBlockKey);
    if (textDidChangeBlock) {
        textDidChangeBlock(searchBar,searchText);
        _searchBar.frame = CGRectMake(10, (self.frame.size.height-_easySearchBarHeight)/2, self.frame.size.width-60, _easySearchBarHeight);
        _cancelBT.hidden = NO;
    }
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    EasySearchBarTextDidEndEditingBlock endEditingBlock = (EasySearchBarTextDidEndEditingBlock)objc_getAssociatedObject(searchBar, &EasySearchBarTextDidEndEditingBlockKey);
    if (endEditingBlock) {
        endEditingBlock(searchBar);
        _searchBar.frame = CGRectMake(10, (self.frame.size.height-_easySearchBarHeight)/2, self.frame.size.width-20, _easySearchBarHeight);
        _cancelBT.hidden = YES;
    }
}
//点击键盘搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    EasySearchBarSearchButtonClickedBlock searchButtonClickedBlock = (EasySearchBarSearchButtonClickedBlock)objc_getAssociatedObject(searchBar, &EasySearchBarSearchButtonClickedBlockKey);
    if (searchButtonClickedBlock) {
        searchButtonClickedBlock(searchBar);
        _searchBar.frame = CGRectMake(10, (self.frame.size.height-_easySearchBarHeight)/2, self.frame.size.width-60, _easySearchBarHeight);
        _cancelBT.hidden = NO;
    }
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    return YES;
}

#pragma mark --- 重写相关属性的set方法
-(void)setEasySearchBarPlaceholder:(NSString *)easySearchBarPlaceholder{
    _easySearchBarPlaceholder = easySearchBarPlaceholder;
    _searchBar.placeholder = easySearchBarPlaceholder;
}
-(void)setEasySearchBarPlaceholderColor:(UIColor *)easySearchBarPlaceholderColor{
    _easySearchBarPlaceholderColor = easySearchBarPlaceholderColor;
    [_searchField setValue:easySearchBarPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

-(void)setEasySearchBarHeight:(CGFloat)easySearchBarHeight{
    _easySearchBarHeight = easySearchBarHeight;
    _searchBar.frame = CGRectMake(0, (self.frame.size.height-easySearchBarHeight)/2, self.frame.size.width-60, easySearchBarHeight);
}
-(void)setEasySearchBarTextColor:(UIColor *)easySearchBarTextColor{
    _easySearchBarTextColor = easySearchBarTextColor;
    _searchField.textColor = easySearchBarTextColor;
}
-(void)setEasyCancelColor:(UIColor *)easyCancelColor{
    _easyCancelColor = easyCancelColor;
    [_cancelBT setTitleColor:easyCancelColor forState:UIControlStateNormal];
}
-(void)setEasyBackgroundColor:(UIColor *)easyBackgroundColor{
    _searchBar.barTintColor = easyBackgroundColor;
    _searchField.backgroundColor = easyBackgroundColor;
}

@end
