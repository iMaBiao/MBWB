//
//  MBEmotionTool.m
//  MBWB
//
//  Created by 浩渺 on 16/5/24.
//  Copyright © 2016年 haomiao. All rights reserved.
//
#define  MBRecentFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"recent_emotions.data"]

#import "MBEmotionTool.h"
#import "MBEmotion.h"
#import "MJExtension.h"

@implementation MBEmotionTool

static NSArray *_defaultEmotions;

static NSArray *_emojiEmotions;

static NSArray *_lxhEmotions;
/**
 *  最近使用的表情
 */
static NSMutableArray *_recentEmotions;

+ (NSArray *)defaultEmotions{
    if (!_defaultEmotions) {
        NSString *plist = [[NSBundle mainBundle]pathForResource:@"EmotionIcons/default/default_info.plist" ofType:nil];
        _defaultEmotions = [MBEmotion mj_objectArrayWithFile:plist];
        
        [_defaultEmotions makeObjectsPerformSelector:@selector(setDirectory:)withObject:@"EmotionIcons/default"];
    }
    return _defaultEmotions;
}

+ (NSArray *)emojiEmotions{
    if (!_emojiEmotions) {
        NSString *plist = [[NSBundle mainBundle]pathForResource:@"EmotionIcons/emoji/emoji_info" ofType:@"plist"];
        _emojiEmotions = [MBEmotion mj_objectArrayWithFile:plist];
        
        [_emojiEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/emoji"];
    }
    return _emojiEmotions;
}

+ (NSArray *)lxhEmotions{
    if (!_lxhEmotions) {
        NSString *plist = [[NSBundle mainBundle]pathForResource:@"EmotionIcons/lxh/lxh_info" ofType:@"plist"];
        _lxhEmotions = [MBEmotion mj_objectArrayWithFile:plist];
        
        [_lxhEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/lxh"];
    }
    return _lxhEmotions;
}

+ (NSArray *)recentEmotions{
    if (!_recentEmotions) {
        //去沙盒中加载最近使用的表情数据
        _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:MBRecentFilePath];
        if (!_recentEmotions) {//沙盒中没有数据
            _recentEmotions = [NSMutableArray array];
        }
    }
    return _recentEmotions;
}

/**
 *  保存最近使用的表情
 */
+ (void)addRecentEmotion:(MBEmotion *)emotion;{
    
    //加载最近使用的表情数据
    [self recentEmotions];
    
    //删除之前的表情
    [_recentEmotions removeObject:emotion];
    
    //添加最新的表情
    [_recentEmotions insertObject:emotion atIndex:0];
    
    //存储到沙盒中
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:MBRecentFilePath];
    
}

/**
 *  根据表情的文字描述找出对应的表情对象
 */
+ (MBEmotion *)emotionWithDesc:(NSString *)desc{
    if (!desc) {
        return nil;
    }
    
    __block MBEmotion *foundEmotion = nil;
    //从默认表情中找
    [[self defaultEmotions]enumerateObjectsUsingBlock:^(MBEmotion *emotion, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([desc isEqualToString:emotion.chs] || [desc isEqualToString:emotion.cht]) {
            foundEmotion = emotion;
            *stop = YES;
        }
    }];
    if (foundEmotion) {
        return  foundEmotion;
    }
    
    //从浪小花表情中找
    [[self lxhEmotions]enumerateObjectsUsingBlock:^(MBEmotion *emotion, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([desc isEqualToString:emotion.chs] || [desc isEqualToString:emotion.cht]) {
            foundEmotion = emotion;
            *stop = YES;
        }
    }];
    return foundEmotion;
    
}

@end
