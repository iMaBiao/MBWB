//
//  MBUser.m
//  MBWB
//
//  Created by 浩渺 on 16/5/16.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBUser.h"

@implementation MBUser

- (BOOL)isVip{
    //是会员
    return self.mbtype > 2;
}

//+ (instancetype)userWithDict:(NSDictionary *)dict{
//    MBUser *user = [[self alloc]init];
//    user.name = dict[@"name"];
//    user.profile_image_url = dict[@"profile_image_url"];
//    return user;
//}

@end
