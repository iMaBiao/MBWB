//
//  NSDate+MB.h
//  MBWB
//
//  Created by 浩渺 on 16/5/19.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MB)
- (BOOL)isToday;
- (BOOL)isYesterday;
- (BOOL)isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;
/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;

@end
