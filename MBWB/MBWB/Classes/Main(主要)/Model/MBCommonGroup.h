//
//  MBCommonGroup.h
//  MBWB
//
//  Created by 浩渺 on 16/5/25.
//  Copyright © 2016年 haomiao. All rights reserved.
//  用一个MBCommonGroup模型来描述每组的信息：组头、组尾、这组的所有行模型

#import <Foundation/Foundation.h>

@interface MBCommonGroup : NSObject
/**
 *  组头
 */
@property(nonatomic,copy)NSString *header;
/**
 *  组尾
 */
@property(nonatomic,copy)NSString *footer;
/**
 *  这组的所有行模型（数组中存放的都是MBCommonItem模型）
 */
@property(nonatomic,strong)NSArray *items;

+ (instancetype)group;

@end
