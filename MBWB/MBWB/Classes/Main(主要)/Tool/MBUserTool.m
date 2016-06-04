//
//  MBUserTool.m
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBUserTool.h"
#import "MJExtension.h"
#import "MBHttpTool.h"

@implementation MBUserTool
+ (void)userInfoWithParam:(MBUserInfoParam *)param success:(void(^)(MBUserInfoResult *result))success failure:(void(^)(NSError * error))failure{
    
    [self getWithUrl:@"https://api.weibo.com/2/users/show.json" param:param resultClass:[MBUserInfoResult class] success:success failure:failure];
    
}

+ (void)unreadCountWithParam:(MBUnreadCountParam *)param success:(void(^)(MBUnreadCountResult *result))success failure:(void(^)(NSError *error))failure{
    
    [self getWithUrl:@"https://rm.api.weibo.com/2/remind/unread_count.json" param:param resultClass:[MBUnreadCountResult class] success:success failure:failure];
}
@end
