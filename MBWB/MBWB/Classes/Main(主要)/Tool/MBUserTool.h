//
//  MBUserTool.h
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBBaseTool.h"
#import "MBUserInfoParam.h"
#import "MBUserInfoResult.h"
#import "MBUnreadCountParam.h"
#import "MBUnreadCountResult.h"

@interface MBUserTool : MBBaseTool
/**
 *  加载用户的个人信息
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)userInfoWithParam:(MBUserInfoParam *)param success:(void(^)(MBUserInfoResult *result))success failure:(void(^)(NSError * error))failure;
/**
 *  获取status未读数
 */
+ (void)unreadCountWithParam:(MBUnreadCountParam *)param success:(void(^)(MBUnreadCountResult *result))success failure:(void(^)(NSError *error))failure;


@end
