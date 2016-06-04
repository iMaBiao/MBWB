//
//  MBCommonItem.h
//  MBWB
//
//  Created by 浩渺 on 16/5/25.
//  Copyright © 2016年 haomiao. All rights reserved.
// 用一个MBCommonItem模型来描述每行的信息：图标、标题、子标题、右边的样式（箭头、文字、数字、开关、打钩）

#import <Foundation/Foundation.h>

@interface MBCommonItem : NSObject
/**
 *  图标
 */
@property(nonatomic,copy)NSString *icon;
/**
 *  标题
 */
@property(nonatomic,copy)NSString *title;
/**
 *  子标题
 */
@property(nonatomic,copy)NSString *subtitle;

/**
 *  右边显示的数字标记
 */
@property(nonatomic,copy)NSString  *badgeValue;

/**
 *  点击这行cell需要跳转到哪个控制器
 */
@property(nonatomic,assign)Class destVcClass;

/**
 *  封装点击这行cell想做的事情
 */
@property(nonatomic,copy)void (^operation)();


+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;
+(instancetype)itemWithTitle:(NSString *)title;


/**
 *  是否隐藏箭头
 */
@property(nonatomic,assign)BOOL hiddenArrow;


@end
