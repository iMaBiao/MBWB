//
//  MBPopMenu.h
//  MBWB
//
//  Created by 浩渺 on 16/5/14.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  背景图的箭头位置
 */
typedef enum{
    MBPopMenuArrowPositionCenter = 0,
    MBPopMenuArrowPositionLeft = 1,
    MBPopMenuArrowPositionRight = 2
} MBPopMenuArrowPosition;

@class MBPopMenu;
@protocol MBPopMenuDelegate <NSObject>

@optional
- (void)popMenuDidDismissed:(MBPopMenu *)popMenu;

@end


@interface MBPopMenu : UIView

@property(nonatomic,weak)id<MBPopMenuDelegate> delegate;

@property(nonatomic,assign)MBPopMenuArrowPosition arrowPosition;

@property(nonatomic,assign,getter = isDimBackground) BOOL dimBackground;


/**
 *  初始化方法
 */
- (instancetype)initWithContentView:(UIView *)contentView;
+ (instancetype)popWithContentView:(UIView *)contentView;
/**
 *  设置菜单背景图片
 */
- (void)setBackgroundImage:(UIImage *)image;
/**
 *  显示菜单
 */
- (void)showInRect:(CGRect)rect;
/**
 *  关闭菜单
 */
- (void)dismissView;
@end
