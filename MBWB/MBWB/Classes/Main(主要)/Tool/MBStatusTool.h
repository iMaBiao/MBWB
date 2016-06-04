//
//  MBStatusTool.h
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
// 微博业务类：处理跟微博相关的一切业务，比如加载微博数据、发微博、删微博

#import <Foundation/Foundation.h>
#import "MBHomeStatusesParam.h"
#import "MBHomeStatusesResult.h"
@interface MBStatusTool : NSObject
/**
 *  加载首页status数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)homeStatusesWithParma:(MBHomeStatusesParam *)param success:(void (^)(MBHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure;

@end
