//
//  MBHomeStatusesResult.h
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
//封装加载首页微博数据的返回结果

#import <Foundation/Foundation.h>

@interface MBHomeStatusesResult : NSObject

/** 微博数组（装着HMStatus模型） */
@property(nonatomic,strong)NSArray *statuses;

/** 近期的微博总数 */
@property(nonatomic,assign)int total_number;

@end
