//
//  MBEmotionTool.h
//  MBWB
//
//  Created by 浩渺 on 16/5/24.
//  Copyright © 2016年 haomiao. All rights reserved.
//  管理表情数据：加载表情数据、存储表情使用记录

#import <Foundation/Foundation.h>
@class MBEmotion;

@interface MBEmotionTool : NSObject


+ (NSArray *)defaultEmotions;

+ (NSArray *)emojiEmotions;

+ (NSArray *)lxhEmotions;

+ (NSArray *)recentEmotions;

/**
 *  保存最近使用的表情
 */
+ (void)addRecentEmotion:(MBEmotion *)emotion;

/**
 *  根据表情的文字描述找出对应的表情对象
 */
+ (MBEmotion *)emotionWithDesc:(NSString *)desc;


@end
