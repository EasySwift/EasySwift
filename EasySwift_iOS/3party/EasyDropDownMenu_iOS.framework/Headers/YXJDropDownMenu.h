//
//  YXJDropDownMenu.h
//  YXJDropDownMenu
//
//  Created by 袁晓钧 on 6/16/16.
//  Copyright (c) 2016 YXJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - indexPath
@interface YXJIndexPath : NSObject

@property (nonatomic, assign) NSInteger column;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) NSInteger item;

- (instancetype)initWithColumn:(NSInteger)column row:(NSInteger)row;

// default item = -1
+ (instancetype)indexPathWithCol:(NSInteger)col row:(NSInteger)row;

+ (instancetype)indexPathWithCol:(NSInteger)col row:(NSInteger)row item:(NSInteger)item;

@end

#pragma mark - YXJCellData
@interface YXJCellData:NSObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *detailText;
@property (nonatomic, strong) UIImage *defaultImage;
@property (nonatomic, strong) UIImage *selectImage;

- (instancetype)initWithTitle:(NSString *)title detailText:(NSString *)detailText defaultImage:(UIImage *)defaultImage selectImage:(UIImage *)selectImage;

@end

#pragma mark - data source protocol
@class YXJDropDownMenu;

@protocol YXJDropDownMenuDataSource <NSObject>

@required
/** 返回 menu 第column列有多少行 */
- (NSInteger)menu:(YXJDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column;

/** 返回 menu 第column列 每行data */
- (YXJCellData *)menu:(YXJDropDownMenu *)menu configRowAtIndexPath:(YXJIndexPath *)indexPath;

@optional
/** 返回 menu 有多少列 ，默认1列 */
- (NSInteger)numberOfColumnsInMenu:(YXJDropDownMenu *)menu;

/** 当有column列 row行 返回有多少个item ，如果>0，说明有二级列表 ，=0 没有二级列表,如果都没有可以不实现该协议 */
- (NSInteger)menu:(YXJDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column;

/** 当有column列 row行 item项 title , 如果都没有可以不实现该协议 */
- (YXJCellData *)menu:(YXJDropDownMenu *)menu configItemsInRowAtIndexPath:(YXJIndexPath *)indexPath;

@end

#pragma mark - delegate
@protocol YXJDropDownMenuDelegate <NSObject>

@optional
/** 点击代理，点击了第column 第row 或者item项，如果 item >=0 */
- (void)menu:(YXJDropDownMenu *)menu didSelectRowAtIndexPath:(YXJIndexPath *)indexPath;

/** return nil if you don't want to user select specified indexpath */
- (NSIndexPath *)menu:(YXJDropDownMenu *)menu willSelectRowAtIndexPath:(YXJIndexPath *)indexPath;

@end

#pragma mark - interface
@interface YXJDropDownMenu : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <YXJDropDownMenuDataSource> dataSource;
@property (nonatomic, weak) id <YXJDropDownMenuDelegate> delegate;

@property (nonatomic, assign) UITableViewCellStyle cellStyle; // default value1
@property (nonatomic, strong) UIColor *indicatorColor;      // 三角指示器颜色
@property (nonatomic, strong) UIColor *textColor;           // 文字title颜色
@property (nonatomic, strong) UIColor *textSelectedColor;   // 文字title选中颜色
@property (nonatomic, strong) UIColor *detailTextColor;     // detailText文字颜色
@property (nonatomic, strong) UIFont *detailTextFont;       // font
@property (nonatomic, strong) UIColor *separatorColor;      // 分割线颜色
@property (nonatomic, assign) NSInteger fontSize;           // 字体大小
// 当有二级列表item时，点击row 是否调用点击代理方法
@property (nonatomic, assign) BOOL isClickHaveItemValid;

@property (nonatomic, getter=isRemainMenuTitle) BOOL remainMenuTitle; // 切换条件时是否更改menu title
@property (nonatomic, strong) NSMutableArray  *selectArray; // 记录每个column选中的raw和item

/**
 *  默认宽度为屏幕宽度
 *  @param origin the origin of this view's frame
 *  @param height menu's height
 *  @return menu
 */
- (instancetype)initWithOrigin:(CGPoint)origin andHeight:(CGFloat)height;

// 获取data
- (YXJCellData *)dataForRowAtIndexPath:(YXJIndexPath *)indexPath;

// 重新加载数据
- (void)reloadData;

// 创建menu 第一次显示 不会调用点击代理，这个手动调用
- (void)selectDefalutIndexPath;

- (void)selectIndexPath:(YXJIndexPath *)indexPath; // 默认trigger delegate

- (void)selectIndexPath:(YXJIndexPath *)indexPath triggerDelegate:(BOOL)trigger; // 调用代理
@end

