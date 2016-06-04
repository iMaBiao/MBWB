//
//  MBAccount.h
//  MBWB
//
//  Created by 浩渺 on 16/5/16.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBAccount : NSObject<NSCoding>

//responseObject = {
//    "access_token" = "2.00oIFVbD0_86ih610d1330f8xkx6bD";
//    "expires_in" = 157679999;
//    "remind_in" = 157679999;
//    uid = 3302530862;
//}

/** string 	用于调用access_token，接口获取授权后的access token。*/
@property(nonatomic,copy)NSString *access_token;

/** string 	access_token的生命周期，单位是秒数。*/
@property(nonatomic,copy)NSString *expires_in;

/** 过期时间 access_token的生命周期（该参数即将废弃，开发者请使用expires_in）*/
@property(nonatomic,strong)NSDate *remind_in;

/** string 	当前授权用户的UID。*/
@property(nonatomic,copy)NSString *uid;

/**用户昵称 */
@property (nonatomic, copy) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dictionary;

@end
